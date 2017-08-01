//
//  LogInViewController.swift
//  ImageBoard
//
//  Created by yangpc on 2017. 7. 31..
//  Copyright © 2017년 yang hee jung (lemon). All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func postLogInIngfo(email: String, password: String) {
        let urlString = "https://ios-api.boostcamp.connect.or.kr/login"
        guard let url = URL(string: urlString) else {
            return
        }
        let parameterDictionary = ["email" : email, "password" : password]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    switch httpResponse.statusCode {
                    case 400..<500:
                        let title = "알림"
                        let message = "\(json)"
                        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
                        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
                        ac.addAction(ok)
                        DispatchQueue.main.async {
                            self.present(ac, animated: true, completion: nil)
                        }
                    default:
                        DispatchQueue.main.async {
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                    
                } catch {
                    print(error)
                }
                
            }
            
            }.resume()
    }
    
       @IBAction func logIn(_ sender: UIButton) {
        guard let email = emailTextField.text,
            let password = passwordTextField.text else {
            return
        }
        if email.isEmpty || password.isEmpty {
            let title = "모든 항목을 입력해주세요."
            let ac = UIAlertController(title: title, message: "", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
            ac.addAction(ok)
            present(ac, animated: true, completion: nil)
        } else {
            postLogInIngfo(email: email, password: password)
        }
    }
}
