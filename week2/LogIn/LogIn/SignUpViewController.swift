//
//  ViewController.swift
//  LogIn
//
//  Created by yangpc on 2017. 7. 11..
//  Copyright © 2017년 yangpc. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: Properties
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet var password: UITextField!
    @IBOutlet var checkPassword: UITextField!

    // 이미지 피커
    private lazy var imagePickerController: UIImagePickerController = {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        return imagePickerController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        // 사용자가 이미지 피커를 여러 번 볼 수도 있다는 가정을 하면, 이미지 피커를 매 번 생성하지 않고, 프로퍼티로 활용해 보는 것은 어떨런지
        present(imagePickerController, animated: true, completion: nil)
    }
    @IBAction func signUpAction(_ sender: UIButton) {
        if password.text != checkPassword.text {
            print("check passwrod")
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}

