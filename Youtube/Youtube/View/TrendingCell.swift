//
//  TrendingCellCollectionViewCell.swift
//  Youtube
//
//  Created by vinay shinde on 12/06/18.
//  Copyright © 2018 vinay shinde. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {
    
    override func fetchVideos() {
        
        ApiService.sharedInstance.fetchVideos(urlString: "trending.json") { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
            
    }
    
}
