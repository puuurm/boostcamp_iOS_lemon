//
//  SignInViewController.swift
//  ImageBoard
//
//  Created by yangpc on 2017. 7. 31..
//  Copyright © 2017년 yang hee jung (lemon). All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var nickNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordCheckTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func showMainView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func postSignInInfo(email: String, password: String, nickname: String) {
        let urlString = "https://ios-api.boostcamp.connect.or.kr/user"
        guard let url = URL(string: urlString) else {
            return
        }
        let parameterDictionary = ["email" : email, "password" : password, "nickname" : nickname]
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
                        let title = "회원가입 완료"
                        let ac = UIAlertController(title: title, message: "", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
                        ac.addAction(ok)
                        DispatchQueue.main.async {
                            self.present(ac, animated: true, completion: nil)
                        }
                    }
                    
                } catch {
                    print(error)
                }
                
            }
            
            }.resume()
    }
    
    @IBAction func signInButtonDidTap(_ sender: UIButton) {
        guard let email = emailTextField.text,
            let nickName = nickNameTextField.text,
            let password = passwordTextField.text,
            let passwordCheck = passwordCheckTextField.text else {
                return
        }
        if email.isEmpty || nickName.isEmpty || password.isEmpty || passwordCheck.isEmpty {
            let title = "모든 항목을 입력해주세요."
            let ac = UIAlertController(title: title, message: "", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
            ac.addAction(ok)
            present(ac, animated: true, completion: nil)
        } else {
            if password != passwordCheck {
                let title = "암호와 암호확인이 일치하지 않습니다."
                let ac = UIAlertController(title: title, message: "", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
                ac.addAction(ok)
                present(ac, animated: true, completion: nil)
                
            } else {
                postSignInInfo(email: email, password: password, nickname: nickName)
            }
        }
        
        
        
    }
}
