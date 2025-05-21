//
//  IssueDetailTableViewController.swift
//  github graphql
//
//  Created by 矢島良乙 on 2025/05/06.
//

import UIKit
import GitHubSchema
import Markdown
import Markdownosaur

class IssueDetailTableViewController: UITableViewController {

    var issueId: ID!
        
    private let apollo = GraphQLClient.shared.apollo
    
    var titleText: String!
    var bodyMarkdown: String?
    var auther: String?
    var autherAvatorURL: URI?
    
    @IBOutlet weak var createCommentButton: UIBarButtonItem!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var loading = true {
        didSet {
            createCommentButton.isEnabled = !loading
            menuButton.isEnabled = !loading
        }
    }
    
    var comments: [GetIssueAndCommentsByIDQuery.Data.Node.AsIssue.Comments.Node] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = titleText
        loading = true
        
        apollo.fetch(query: GitHubSchema.GetIssueAndCommentsByIDQuery(id: issueId, after: nil), cachePolicy: .fetchIgnoringCacheData) { [self] result in
            guard let data = try? result.get().data else { return }
            titleText = data.node?.asIssue?.title
            bodyMarkdown = data.node?.asIssue?.body ?? ""
            comments = (data.node?.asIssue?.comments.nodes?.compactMap(\.!))!
            print(comments)
            auther = data.node?.asIssue?.author?.login
            autherAvatorURL = data.node?.asIssue?.author?.avatarUrl
            
            var elements: [UIMenuElement] = []
            
            if let canUpdate = data.node?.asIssue?.viewerCanUpdate, canUpdate {
                elements.append(UIAction(title: "Edit Issue", image: UIImage(systemName: "pencil"), handler: { _ in
                    self.performSegue(withIdentifier: "toEditIssue", sender: nil)
                }))
            }
            
            if let canDelete = data.node?.asIssue?.viewerCanDelete, canDelete {
                elements.append(UIAction(title: "Delete Issue", image: UIImage(systemName: "trash"), handler: { _ in
                    let alert = UIAlertController(title: "このIssueを削除しますか。", message: "この操作は取り消せません。", preferredStyle: .alert)
                    let deleteAction = UIAlertAction(title: "はい", style: .destructive) { [self] _ in
                        apollo.perform(mutation: GitHubSchema.DeleteIssueMutation(issueId: issueId)) { result in
                            switch result {
                            case .success(_):
                                let alert = UIAlertController(title: nil, message: "削除されました", preferredStyle: .alert)
                                let okAction = UIAlertAction(title: "OK", style: .default) { [self] _ in
                                    if let previousVC = self.navigationController?.viewControllers.first(where: { $0 is IssuesTableViewController }) as? IssuesTableViewController {
                                        previousVC.shouldRefresh = true
                                        previousVC.deleteid = self.issueId
                                    }
                                    self.navigationController?.popViewController(animated: true)
                                }
                                alert.addAction(okAction)
                                self.present(alert, animated: true)
                            case .failure(let error):
                                print("Error fetching issues: \(error)")
                                let alert = UIAlertController(title: "エラー", message: error.localizedDescription, preferredStyle: .alert)
                                let okAction = UIAlertAction(title: "OK", style: .default)
                                alert.addAction(okAction)
                                self.present(alert, animated: true)
                            }
                        }
                    }
                    let cancelAction = UIAlertAction(title: "いいえ", style: .cancel)
                    alert.addAction(cancelAction)
                    alert.addAction(deleteAction)
                    self.present(alert, animated: true)
                }))
            }
            
            let menu = UIMenu(title: "", options: [], children: elements)
            menuButton.menu = menu
            loading = false
            if elements.isEmpty {
                menuButton.isEnabled = false
                //menuButton.isHidden = true
            }
            tableView.reloadData()
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return comments.count + 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var conf = cell.defaultContentConfiguration()
        
        cell.accessoryView = nil
        
        // Configure the cell...
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                conf.text = auther
            default:
                var document: Document!
                if let bodyMarkdown = bodyMarkdown {
                    document = Document(parsing: bodyMarkdown.isEmpty ? "_No description provided._" : bodyMarkdown)
                } else {
                   document = Document(parsing: "loading...")
                }
                var markdownosaur = Markdownosaur()
                conf.attributedText = markdownosaur.attributedString(from: document)
            }
        default:
            switch indexPath.row {
            case 0:
                conf.text = comments[indexPath.section - 1].author?.login
                let button = UIButton()
                button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
                button.sizeToFit()
                var actions: [UIAction] = []
                if comments[indexPath.section - 1].viewerCanUpdate {
                    actions.append(UIAction(title: "Edit", image: UIImage(systemName: "pencil")) { [self] _ in
                        performSegue(withIdentifier: "toEditComment", sender: comments[indexPath.section - 1])
                    })
                }
                if comments[indexPath.section - 1].viewerCanDelete {
                    actions.append(UIAction(title: "Delete", image: UIImage(systemName: "trash")) { _ in
                        let alert = UIAlertController(title: "このコメントを削除しますか。", message: "この操作は取り消せません。", preferredStyle: .alert)
                        let deleteAction = UIAlertAction(title: "はい", style: .destructive) { [self] _ in
                            apollo.perform(mutation: GitHubSchema.DeleteIssueCommentMutation(id: comments[indexPath.section - 1].id)) { result in
                                switch result {
                                case .success(_):
                                    let alert = UIAlertController(title: nil, message: "削除されました", preferredStyle: .alert)
                                    let okAction = UIAlertAction(title: "OK", style: .default) { [self] _ in
                                        comments.remove(at: indexPath.section - 1)
                                        tableView.deleteSections([indexPath.section], with: .fade)
                                    }
                                    alert.addAction(okAction)
                                    self.present(alert, animated: true)
                                case .failure(let error):
                                    print("Error fetching issues: \(error)")
                                    let alert = UIAlertController(title: "エラー", message: error.localizedDescription, preferredStyle: .alert)
                                    let okAction = UIAlertAction(title: "OK", style: .default)
                                    alert.addAction(okAction)
                                    self.present(alert, animated: true)
                                }
                            }
                        }
                        let cancelAction = UIAlertAction(title: "いいえ", style: .cancel)
                        alert.addAction(cancelAction)
                        alert.addAction(deleteAction)
                        self.present(alert, animated: true)
                    })
                }
                button.menu = UIMenu(title: "", options: [], children: actions)
                button.isEnabled = !actions.isEmpty
                button.showsMenuAsPrimaryAction = true
                cell.accessoryView = button
            default:
                let document = Document(parsing: comments[indexPath.section - 1].body)
                var markdownosaur = Markdownosaur()
                conf.attributedText = markdownosaur.attributedString(from: document)
            }
        }
        
        cell.contentConfiguration = conf

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        switch segue.identifier {
        case "toAddComment":
            guard let navC = segue.destination as? UINavigationController,
                  let vc = navC.viewControllers.first as? AddCommentViewController
            else { return }
            vc.presentationController?.delegate = self
            vc.issueId = issueId
        case "toEditIssue":
            guard let navC = segue.destination as? UINavigationController,
                  let vc = navC.viewControllers.first as? EditIssueViewController
            else { return }
            vc.presentationController?.delegate = self
            vc.issueId = issueId
            vc.titleText = titleText
            vc.bodyText = bodyMarkdown
        case "toEditComment":
            guard let navC = segue.destination as? UINavigationController,
                  let vc = navC.viewControllers.first as? EditCommentViewController,
                  let comment = sender as? GetIssueAndCommentsByIDQuery.Data.Node.AsIssue.Comments.Node
            else { return }
            vc.presentationController?.delegate = self
            vc.commentId = comment.id
            vc.body = comment.body
        default:
            break
        }
    }

}

extension IssueDetailTableViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
//        hasNextPage = false
//        loadingNextPage = true
        apollo.fetch(query: GitHubSchema.GetIssueAndCommentsByIDQuery(id: issueId, after: nil), cachePolicy: .fetchIgnoringCacheData) { [self] result in
            guard let data = try? result.get().data else { return }
            titleText = data.node?.asIssue?.title
            bodyMarkdown = data.node?.asIssue?.body ?? ""
            comments = (data.node?.asIssue?.comments.nodes?.compactMap(\.!))!
            print(comments)
            auther = data.node?.asIssue?.author?.login
            autherAvatorURL = data.node?.asIssue?.author?.avatarUrl
            tableView.reloadData()
        }
    }
}
