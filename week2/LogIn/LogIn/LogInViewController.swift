//
//  LogInViewController.swift
//  LogIn
//
//  Created by yangpc on 2017. 7. 14..
//  Copyright © 2017년 yangpc. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    
    
    @IBAction func signIn(_ sender: UIButton) {
        print("touch up inside - sign in")
        print("ID : \(idTextField.text ?? ""), PW : \(pwTextField.text ?? "")")
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        print("touch up inside - sign up")
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
