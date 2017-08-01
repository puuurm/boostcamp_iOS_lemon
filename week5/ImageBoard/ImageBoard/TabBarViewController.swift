//
//  TabBarViewController.swift
//  ImageBoard
//
//  Created by yangpc on 2017. 7. 31..
//  Copyright © 2017년 yang hee jung (lemon). All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    let dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImage()
    }
    
    
    
    func getImage() {
        let urlString = "https://ios-api.boostcamp.connect.or.kr"
        guard let url = URL(string: urlString) else {
            return
        }
        let request = URLRequest(url: url)
        let session = URLSession.shared
        
        session.dataTask(with: request) {
            (data, response, error) -> Void in
            if let data = data {
                do {
                    guard let json: [NSDictionary] = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [NSDictionary] else {
                        return
                    }
                    for dictionary in json {
                        guard let title = dictionary["image_title"] as? String,
                            let description = dictionary["image_desc"] as? String,
                            let author = dictionary["author_nickname"] as? String,
                            let dateInt = dictionary["created_at"] as? Int,
                            let image = dictionary["image_url"] as? String,
                            let thumbnail = dictionary["thumb_image_url"] as? String,
                            let imageURL = URL(string: urlString + image),
                            let thumbnailURL = URL(string: urlString + thumbnail) else {
                                return
                        }
                        let dateCreated = self.dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(dateInt)))
                        let photo = Photo(title: title, description: description, author: author, date: dateCreated, image: imageURL, thumbImage: thumbnailURL)
                        let imageRequest = URLRequest(url: thumbnailURL)
                        let imageSession = URLSession.shared
                        imageSession.dataTask(with: imageRequest) {
                            (data, response, error) -> Void in
                            guard let imageData = data else {
                                return
                            }
                            photo.thumbnailImage = UIImage(data: imageData)
                        }.resume()
                        PhotoStore.allPhotos.append(photo)
                    }
                    
                } catch {
                    print(error)
                }
            }
            }.resume()
    }
}
