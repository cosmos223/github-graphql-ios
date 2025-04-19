//
//  RepositoryListTableViewController.swift
//  github graphql
//
//  Created by 矢島良乙 on 2025/04/18.
//

import UIKit
import GitHubSchema

class RepositoryListTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var reposiostories: [GetRepositoriesQuery.Data.Search.Node.AsRepository] = []
    
    private var endCursor: String?
    private var hasNextPage = false
    
    private let apollo = GraphQLClient.shared.apollo
    
    let controller = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        controller.searchResultsUpdater = self
        controller.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = controller
        
        navigationItem.hidesSearchBarWhenScrolling = false
        
    }
    
    // MARK: - Search Controller
    
    var fetch: DispatchWorkItem?
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        
        hasNextPage = false
        
        fetch?.cancel()
        fetch = DispatchWorkItem() { [self] in
            apollo.fetch(query: GitHubSchema.GetRepositoriesQuery(query: GraphQLNullable(stringLiteral: searchText), after: .none)) { [self] result in
                switch result {
                case .success(let value):
                    guard let data = value.data else { return }
                    reposiostories = (data.search.nodes?.compactMap(\.?.asRepository))!
                    endCursor = data.search.pageInfo.endCursor
                    hasNextPage = data.search.pageInfo.hasNextPage
                    print(reposiostories)
                    tableView.reloadData()
                case .failure(let error):
                    let alert = UIAlertController(title: "エラー", message: error.localizedDescription, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default)
                    alert.addAction(okAction)
                    self.present(alert, animated: true)
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: fetch!)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return reposiostories.count == 0 ? 1 : reposiostories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        
        if reposiostories.count == 0 {
            if let searchText = controller.searchBar.text {
                if searchText.isEmpty {
                    content.text = "検索文字列を入力してください"
                } else {
                    content.text = "データなし"
                }
            } else {
                content.text = "データなし"
            }
        } else {
            content.text = reposiostories[indexPath.row].nameWithOwner
            content.secondaryText = reposiostories[indexPath.row].description
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
        guard let searchText = controller.searchBar.text else { return }
        let endCursorNullable: GraphQLNullable<String> = self.endCursor ?? .none
        apollo.fetch(query: GitHubSchema.GetRepositoriesQuery(query: GraphQLNullable(stringLiteral: searchText), after: endCursorNullable)) { [self] result in
            switch result {
                case .success(let value):
                guard let data = value.data else { return }
                //print(data.search.nodes?.first??.asRepository?.nameWithOwner)
                //print(data.search.nodes?.count)
                reposiostories.append(contentsOf: (data.search.nodes?.compactMap(\.?.asRepository))!)
                endCursor = data.search.pageInfo.endCursor
                hasNextPage = data.search.pageInfo.hasNextPage
                print(reposiostories.count)
                tableView.reloadData()
                loadingNextPage = false
            case .failure(let error):
                let alert = UIAlertController(title: "エラー", message: error.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default)
                alert.addAction(okAction)
                self.present(alert, animated: true)
                loadingNextPage = false
            }
            
        }
    }
    
    // MARK: - Navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        switch identifier {
        case "toIssue":
            return reposiostories.count != 0
        default:
            return true
        }
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? IssuesTableViewController,
           let indexPath = tableView.indexPathForSelectedRow {
            destination.repositoryId = reposiostories[indexPath.row].id
            destination.navTitle = reposiostories[indexPath.row].nameWithOwner
        }
    }

}
