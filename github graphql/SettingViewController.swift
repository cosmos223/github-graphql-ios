//
//  SettingViewController.swift
//  github graphql
//
//  Created by 矢島良乙 on 2025/04/18.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var tokenTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tokenTextField.placeholder = "Github Personal Access Token"
        tokenTextField.text = UserDefaults.standard.string(forKey: "accessToken")

        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UserDefaults.standard.set(tokenTextField.text, forKey: "accessToken")
    }
    
    @IBAction func close(_ sender: Any) {
        UserDefaults.standard.set(tokenTextField.text, forKey: "accessToken")
        dismiss(animated: true)
    }

}
