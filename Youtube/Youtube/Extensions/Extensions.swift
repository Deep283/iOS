//
//  Extensions.swift
//  Youtube
//
//  Created by vinay shinde on 12/03/18.
//  Copyright © 2018 vinay shinde. All rights reserved.
//

import UIKit
extension UIView
{
    func addContraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index,view) in views.enumerated()
        {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

var imageCache = NSCache<AnyObject, AnyObject>()
class CustomImageView: UIImageView{
    
    var imageUrlString: String?
    func loadImageUsingUrl(imageUrl: String) {
        
        imageUrlString = imageUrl
        let url = URL(string: imageUrl)
        image = nil
        if let imageFromCache = imageCache.object(forKey: imageUrl as AnyObject) as? UIImage
        {
            self.image = imageFromCache
            return
        }
        URLSession.shared.dataTask(with: url!) { (data, response, err) in
            if err != nil{
                print(err!)
                return
            }
            DispatchQueue.main.async {
                
                let imageToCache = UIImage(data: data!)
                if imageUrl == self.imageUrlString
                {
                     self.image = imageToCache
                }
                imageCache.setObject(imageToCache!, forKey: imageUrl as AnyObject)
            }
            }.resume()
    }
}





