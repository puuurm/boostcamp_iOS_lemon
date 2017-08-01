//
//  ImageStore.swift
//  HomepwnerThird
//
//  Created by yangpc on 2017. 7. 29..
//  Copyright © 2017년 yang hee jung (lemon). All rights reserved.
//

import UIKit
class ImageStore {
    
    let cache = NSCache<AnyObject, AnyObject>()
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
        
        let url = imageURLForKey(key: key)
        if let data = UIImageJPEGRepresentation(image, 0.5) {
            try? data.write(to: url, options: .atomic)
        }
    }
    
    func image(forKey key: String) -> UIImage? {
        
        if let existingImage = cache.object(forKey: key as NSString) as? UIImage {
            return existingImage
        }
        
        let url = imageURLForKey(key: key)
        guard let imageFromDisk = UIImage(contentsOfFile: url.path) else {
            return nil
        }
        
        cache.setObject(imageFromDisk, forKey: key as NSString)
        return imageFromDisk
    }
    
    func deleteImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
        
        let url = imageURLForKey(key: key)
        do {
            try FileManager.default.removeItem(at: url)
        } catch let deleteError {
            print("Error removing the image from disk: \(deleteError)")
        }
        
    }
    
    func imageURLForKey(key: String) -> URL {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent(key)
    }
}
