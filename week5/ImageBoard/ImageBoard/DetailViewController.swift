//
//  DetailViewController.swift
//  ImageBoard
//
//  Created by yangpc on 2017. 8. 1..
//  Copyright © 2017년 yang hee jung (lemon). All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var detailImageView: UIImageView!
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var titleLabel: UINavigationItem!
    
    var photo: Photo!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        detailImageView.image = photo.image
        nicknameLabel.text = photo.authorNickname
        descriptionLabel.text = photo.description
        dateLabel.text = photo.dateTaken
        titleLabel.title = photo.title
    }
}
