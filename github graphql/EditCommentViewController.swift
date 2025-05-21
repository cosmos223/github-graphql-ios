//
//  AddCommentViewController.swift
//  github graphql
//
//  Created by 矢島良乙 on 2025/05/07.
//

import UIKit
import GitHubSchema
import Markdown
import Markdownosaur

class EditCommentViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var previewTextView: UITextView!
    @IBOutlet weak var stackView: UIStackView!
    
    var commentId: ID!
    var body: String!
    
    private let apollo = GraphQLClient.shared.apollo

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        
        textView.text = body
        
        isModalInPresentation = false
        let document = Document(parsing: textView.text)
        var markdownosaur = Markdownosaur()
        previewTextView.attributedText = markdownosaur.attributedString(from: document)
        
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.opaqueSeparator.cgColor
        textView.layer.cornerRadius = 8
        
        previewTextView.layer.cornerRadius = 8
        
        NSLayoutConstraint.activate([
            view.keyboardLayoutGuide.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8)
        ])

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if stackView.bounds.height > stackView.bounds.width {
            stackView.axis = .vertical
        } else {
            stackView.axis = .horizontal
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        isModalInPresentation = textView.text != body
        let document = Document(parsing: textView.text)
        var markdownosaur = Markdownosaur()
        previewTextView.attributedText = markdownosaur.attributedString(from: document)
    }
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        if textView.text.isEmpty {
            let alert = UIAlertController(title: "エラー", message: "入力してください", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
        } else {
            apollo.perform(mutation: GitHubSchema.UpdateIssueCommentMutation(id: commentId, body: textView.text)) { result in
                switch result {
                case .success(let value):
                    let alert = UIAlertController(title: nil, message: "更新されました", preferredStyle: .alert)
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
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
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
