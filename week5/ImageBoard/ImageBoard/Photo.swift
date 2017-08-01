//
//  Photo.swift
//  ImageBoard
//
//  Created by yangpc on 2017. 8. 1..
//  Copyright © 2017년 yang hee jung (lemon). All rights reserved.
//

import UIKit

class Photo {
    let title: String
    let description: String
    let authorNickname: String
    let dateTaken: String
    let imageURL: URL
    open let thumbImageURL: URL
    
    var thumbnailImage: UIImage?
    var image: UIImage?
    
    
    init(title: String, description: String, author: String, date: String, image: URL, thumbImage: URL) {
        self.title = title
        self.description = description
        self.authorNickname = author
        self.dateTaken = date
        self.imageURL = image
        self.thumbImageURL = thumbImage
    }
}
