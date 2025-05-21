//
//  AdvancedSearchViewController.swift
//  github graphql
//
//  Created by 矢島良乙 on 2025/05/21.
//

import UIKit
import Collections

struct QueryType {
    let label: String
    let query: String
    let number: Bool
}

class AdvancedSearchViewController: UIViewController {

    let queryTypes: [QueryType] = [
        .init(label: "Name", query: "in:name ", number: false),
        .init(label: "User", query: "user:", number: false),
        .init(label: "Language", query: "language:", number: false),
        .init(label: "Star", query: "stars:", number: true),
        .init(label: "Fork", query: "forks:", number: true),
        .init(label: "Organization", query: "org:", number: false),
    ]
    
    let numPopUps: OrderedDictionary<String, String> = ["より大きい": ">", "以上": ">=", "と同じ": "", "以下": "<=", "未満": "<"]
    
    @IBOutlet weak var stackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var topTextField: UITextField!
        
        for (i, query) in queryTypes.enumerated() {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.alignment = .fill
            stack.distribution = .fill
            stack.spacing = 8
            
            let label = UILabel()
            label.tag = 1
            label.text = query.label
            label.font = UIFont.preferredFont(forTextStyle: .body)
            stack.addArrangedSubview(label)
            
            let textField = UITextField()
            textField.tag = 2
            textField.font = UIFont.preferredFont(forTextStyle: .body)
            textField.borderStyle = .roundedRect
            textField.translatesAutoresizingMaskIntoConstraints = false
            stack.addArrangedSubview(textField)
            
            if query.number {
                textField.keyboardType = .numberPad
                let popUpBtn = UIButton(configuration: .tinted())
                popUpBtn.tag = 3
                popUpBtn.menu = UIMenu(children: numPopUps.map { key, _ in
                    UIAction(title: key, identifier: nil) { _ in }
                })
                popUpBtn.showsMenuAsPrimaryAction = true
                popUpBtn.changesSelectionAsPrimaryAction = true
                stack.addArrangedSubview(popUpBtn)
            }
            
            // 最後から数えて一つ前に挿入
            stackView.insertArrangedSubview(stack, at: stackView.arrangedSubviews.count - 1)
            
            if i == 0 {
                topTextField = textField
            } else {
                NSLayoutConstraint.activate([
                    textField.leadingAnchor.constraint(equalTo: topTextField.leadingAnchor),
                ])
            }
            
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func search(_ sender: UIButton) {
        var querys: [String] = []
        for (i, stack) in stackView.arrangedSubviews.enumerated() {
            if let textField = stack.viewWithTag(2) as? UITextField {
                let queryType = queryTypes[i]
                if !(textField.text ?? "").isEmpty {
                    if queryType.number {
                        let popUp = stack.viewWithTag(3) as! UIButton
                        // stars:>10 の形にする
                        querys.append(queryType.query + numPopUps[popUp.titleLabel!.text!]! + textField.text!)
                    } else {
                        querys.append(queryType.query + textField.text!)
                    }
                }
            }
        }
        if querys.isEmpty {
            let alert = UIAlertController(title: "エラー", message: "少なくとも一つは入力してください", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
        } else {
            performSegue(withIdentifier: "toResult", sender: querys)
        }
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "toResult" {
            let vc = segue.destination as! AdvancedSearchResultTableViewController
            vc.querys = (sender as! [String])
        }
    }

}
