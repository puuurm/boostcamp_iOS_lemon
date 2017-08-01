//
//  DetailViewController.swift
//  ImageBoard
//
//  Created by yangpc on 2017. 8. 1..
//  Copyright © 2017년 yang hee jung (lemon). All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var titleNaviItem: UINavigationItem!
    @IBOutlet var authorNickname: UILabel!
    @IBOutlet var dateCreated: UILabel!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var imageView: UIImageView!
    var photo: Photo!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imageView.image = photo.image
        titleNaviItem.title = photo.title
        authorNickname.text = photo.authorNickname
        dateCreated.text = photo.dateTaken
        descriptionTextView.text = photo.description
    }
}
