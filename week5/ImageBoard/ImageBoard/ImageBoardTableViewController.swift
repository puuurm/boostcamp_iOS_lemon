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

    override func viewDidLoad() {
        super.viewDidLoad()
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
                let photo = PhotoStore.allPhotos[row]
                let detailViewController = segue.destination as! DetailViewController
                
                detailViewController.photo = photo
            }
        }
    }
    
    
}

extension ImageBoardTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PhotoStore.allPhotos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageBoardCell", for: indexPath) as! ImageBoardCell
        let imageBoard = PhotoStore.allPhotos[indexPath.row]
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
