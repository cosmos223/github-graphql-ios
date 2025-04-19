//
//  CreateIssueViewController.swift
//  github graphql
//
//  Created by 矢島良乙 on 2025/04/18.
//

import UIKit
import GitHubSchema

class CreateIssueViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    var repositoryId: ID!
    
    private let apollo = GraphQLClient.shared.apollo

    override func viewDidLoad() {
        super.viewDidLoad()

        bodyTextView.layer.borderColor = UIColor.systemGray3.cgColor
        bodyTextView.layer.borderWidth = 1
        bodyTextView.layer.cornerRadius = 4
        bodyTextView.isScrollEnabled = false
        
        isModalInPresentation = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func create(sender: UIBarButtonItem) {
        guard let title = titleTextField.text, !title.isEmpty else {
            let alert = UIAlertController(title: "エラー", message: "タイトルは必須項目です。", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true)
            return
        }
        let body: GraphQLNullable<String> = bodyTextView.text ?? .none
        apollo.perform(mutation: GitHubSchema.CreateIssueMutation(repositoryId: repositoryId, title: title, body: body)) { result in
            switch result {
            case .success(let value):
                let alert = UIAlertController(title: nil, message: "作成されました", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                    if let prevVC = self.presentationController {
                        prevVC.delegate?.presentationControllerDidDismiss?(prevVC)
                    }
                    self.dismiss(animated: true)
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

}
