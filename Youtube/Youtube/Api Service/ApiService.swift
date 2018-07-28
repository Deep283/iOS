//
//  ApiService.swift
//  Youtube
//
//  Created by vinay shinde on 04/06/18.
//  Copyright © 2018 vinay shinde. All rights reserved.
//

import UIKit

class ApiService: NSObject {

    static let sharedInstance = ApiService()
    
    func fetchVideos(urlString: String, completion: @escaping ([Video]) -> ())  {
        let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets/"
        let jsonUrlString = "\(baseUrl)\(urlString)"
        guard let url = URL(string: jsonUrlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            if err != nil{
                print(err!)
                return
            }
            guard let data = data else { return }
            
            var videos = [Video]()
            
            do{
                videos = try JSONDecoder().decode([Video].self, from: data)
                DispatchQueue.main.async {
                    completion(videos)
                }
            }catch let jsonErr{
                print("Error in serializing json:",jsonErr)
            }
            
            }.resume()
    }
    
}
