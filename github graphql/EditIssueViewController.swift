//
//  EditIssueViewController.swift
//  github graphql
//
//  Created by 矢島良乙 on 2025/05/12.
//

import UIKit
import GitHubSchema

class EditIssueViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    var titleText: String!
    var bodyText: String!
    
    var issueId: ID!
    
    private let apollo = GraphQLClient.shared.apollo

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.text = titleText
        bodyTextView.text = bodyText
        
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
    
    @IBAction func save(sender: UIBarButtonItem) {
        guard let title = titleTextField.text, !title.isEmpty else {
            let alert = UIAlertController(title: "エラー", message: "タイトルは必須項目です。", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true)
            return
        }
        let body: GraphQLNullable<String> = bodyTextView.text ?? .none
        apollo.perform(mutation: GitHubSchema.UpdateIssueMutation(id: issueId, title: titleTextField.text!, body: body)) { result in
            switch result {
            case .success(let value):
                let alert = UIAlertController(title: nil, message: "編集が保存されました", preferredStyle: .alert)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
