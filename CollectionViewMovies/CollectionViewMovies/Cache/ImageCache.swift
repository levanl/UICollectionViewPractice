//
//  ImageCache.swift
//  CollectionViewMovies
//
//  Created by Levan Loladze on 11.11.23.
//

import UIKit

class ImageCache {
    static func storeImage(urlString: String, img: UIImage) {
        let path = NSTemporaryDirectory().appending(UUID().uuidString)
        let url = URL(fileURLWithPath: path)
        
        let data = img.jpegData(compressionQuality: 0.5)
        try? data?.write(to: url)
        
        var dict = UserDefaults.standard.object(forKey: "ImageCache") as? 
        [String: String]
        if dict == nil {
            dict = [String: String]()
        }
        dict![urlString] = path
        UserDefaults.standard.set(dict, forKey: "ImageCache")
        
    }
}
