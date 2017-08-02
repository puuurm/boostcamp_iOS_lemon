//
//  ImageBoardTableViewController.swift
//  ImageBoard
//
//  Created by yangpc on 2017. 7. 31..
//  Copyright © 2017년 yang hee jung (lemon). All rights reserved.
//
import UIKit

class ImageBoardTableViewController: UIViewController {
    
    @IBOutlet var imageBoardTableView: UITableView!
    
    var photos = [Photo]()
    
    private let dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImage()
        let lController = self.storyboard?.instantiateViewController(withIdentifier: "LogInNavController") as? NavController
        self.present(lController!, animated: false, completion: nil)
        imageBoardTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imageBoardTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailView" {
            if let row = imageBoardTableView.indexPathForSelectedRow?.row {
                let photo = photos[row]
                let detailViewController = segue.destination as! DetailViewController
                
                detailViewController.photo = photo
            }
        }
    }
    
    // 외부에서도 쓰이는 메서드인가요?
    func getImage() {
        print(photos.count)
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
                    guard let json: [NSMutableDictionary] = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [NSMutableDictionary] else {
                        return
                    }
                    
                    print(json.count)
                    
                    for dictionary in json {
                        guard let title = dictionary["image_title"] as? String,
                            let description = dictionary["image_desc"] as? String,
                            let author = dictionary["author_nickname"] as? String,
                            let dateInt = dictionary["created_at"] as? Int,
                            let image = dictionary["image_url"] as? String,
                            let thumbnail = dictionary["thumb_image_url"] as? String,
                            let imageURL = URL(string: urlString + image),
                            let thumbnailURL = URL(string: urlString + thumbnail) else {
                                continue
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
                        self.photos.append(photo)
                    }
                    DispatchQueue.main.async {
                        self.imageBoardTableView.reloadData()
                    }
                } catch {
                    print(error)
                }
            }
            }.resume()
    }

    
}

extension ImageBoardTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(photos.count)
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageBoardCell", for: indexPath) as! ImageBoardCell
        let imageBoard = photos[indexPath.row]
        cell.titleLabel.text = imageBoard.title
        cell.authorNicknameLabel.text = imageBoard.authorNickname
        cell.createDateLabel.text = imageBoard.dateTaken
        cell.thumbnailImageView.image = imageBoard.thumbnailImage
        
        let imageRequest = URLRequest(url: imageBoard.imageURL)
        let imageSession = URLSession.shared
        imageSession.dataTask(with: imageRequest) {
            (data, response, error) -> Void in
            guard let imageData = data else {
                return
            }
            imageBoard.image = UIImage(data: imageData)
        }.resume()
        return cell
    }
    
}
