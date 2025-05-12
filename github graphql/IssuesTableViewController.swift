//
//  IssuesTableViewController.swift
//  github graphql
//
//  Created by 矢島良乙 on 2025/04/18.
//

import UIKit
import GitHubSchema

class IssuesTableViewController: UITableViewController {
    
    var repositoryId: ID!
    var navTitle: String!
    
    var issues: [GetIssuesByRepositoryIDQuery.Data.Node.AsRepository.Issues.Node] = []
    
    private var endCursor: String?
    private var hasNextPage = false
    
    private let apollo = GraphQLClient.shared.apollo
    
    var shouldRefresh = false
    var deleteid: ID?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if shouldRefresh {
            issues.removeAll(where: { $0.id == deleteid })
            tableView.reloadData()
            shouldRefresh = false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = navTitle + " issues"
        
        navigationItem.setValue(true, forKey: "__largeTitleTwoLineMode")
        
        loadingNextPage = true
        apollo.fetch(query: GitHubSchema.GetIssuesByRepositoryIDQuery(id: repositoryId, after: .none), cachePolicy: .fetchIgnoringCacheData) { [self] result in
            guard let data = try? result.get().data else { return }
            issues = (data.node?.asRepository?.issues.nodes?.compactMap(\.!))!
            endCursor = data.node?.asRepository?.issues.pageInfo.endCursor
            hasNextPage = data.node?.asRepository?.issues.pageInfo.hasNextPage ?? false
            print(issues.count)
            tableView.reloadData()
            loadingNextPage = false
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return issues.count == 0 ? 1 : issues.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        
        if issues.count == 0 {
            content.text = "データなし"
        } else {
            content.text = issues[indexPath.row].title
            content.secondaryText = issues[indexPath.row].author?.login
        }
        
        cell.contentConfiguration = content

        return cell
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard hasNextPage else { return }
        let position = scrollView.contentOffset.y
        let height = scrollView.contentSize.height - scrollView.frame.size.height

        if position > height - 100 {
            loadNextPage()
        }
    }
    
    var loadingNextPage = false
    func loadNextPage() {
        guard !loadingNextPage else { return }
        loadingNextPage = true
        let endCursorNullable: GraphQLNullable<String> = self.endCursor ?? .none
        apollo.fetch(query: GitHubSchema.GetIssuesByRepositoryIDQuery(id: repositoryId, after: endCursorNullable)) { [self] result in
            guard let data = try? result.get().data else { return }
            issues.append(contentsOf: (data.node?.asRepository?.issues.nodes?.compactMap(\.!))!)
            endCursor = data.node?.asRepository?.issues.pageInfo.endCursor
            hasNextPage = data.node?.asRepository?.issues.pageInfo.hasNextPage ?? false
            print(issues.count)
            tableView.reloadData()
            loadingNextPage = false
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toCreateIssue" {
            guard let navC = segue.destination as? UINavigationController,
                  let vc = navC.viewControllers.first as? CreateIssueViewController
            else { return }
            vc.presentationController?.delegate = self
            vc.repositoryId = repositoryId
        } else if segue.identifier == "toIssueDetail" {
            guard let vc = segue.destination as? IssueDetailTableViewController,
                  let indexPath = tableView.indexPathForSelectedRow
            else { return }
            vc.issueId = issues[indexPath.row].id
            vc.titleText = issues[indexPath.row].title
            vc.auther = issues[indexPath.row].author?.login
        }
    }

}

extension IssuesTableViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        hasNextPage = false
        loadingNextPage = true
        apollo.fetch(query: GitHubSchema.GetIssuesByRepositoryIDQuery(id: repositoryId, after: .none), cachePolicy: .fetchIgnoringCacheData) { [self] result in
            guard let data = try? result.get().data else { return }
            issues = (data.node?.asRepository?.issues.nodes?.compactMap(\.!))!
            endCursor = data.node?.asRepository?.issues.pageInfo.endCursor
            hasNextPage = data.node?.asRepository?.issues.pageInfo.hasNextPage ?? false
            print(issues.count)
            tableView.reloadData()
            loadingNextPage = false
        }
    }
}
