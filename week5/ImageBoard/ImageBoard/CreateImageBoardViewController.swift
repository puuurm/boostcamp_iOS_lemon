//
//  ViewController.swift
//  ImageBoard
//
//  Created by yangpc on 2017. 7. 30..
//  Copyright © 2017년 yang hee jung (lemon). All rights reserved.
//

import UIKit

class CreateImageBoardViewController: UIViewController {

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var descriptionTextView: UITextView!
    
    let imagePickerController = UIImagePickerController()
    
    let urlString = "https://ios-api.boostcamp.connect.or.kr/image"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func postImageBoard() {
        guard let url = URL(string: urlString) else {
            return
        }
        //var request = URLRequest(url: url)
        //request.httpMethod = "POST"
        let boundary = "Boundary-\(UUID().uuidString)"
        //request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        //request.httpBody =
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func dismiss(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
}

extension CreateImageBoardViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        imageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
        
    }
    
}






