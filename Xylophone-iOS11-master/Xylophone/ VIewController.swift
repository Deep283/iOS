//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 27/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController{
    
    var xylophoneSoundEffects: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }



    @IBAction func notePressed(_ sender: UIButton) {
        
        let path = Bundle.main.path(forResource: "note\(sender.tag)", ofType: "wav")
        let url = URL(fileURLWithPath: path!)
        
        do{
            xylophoneSoundEffects = try AVAudioPlayer(contentsOf: url)
            xylophoneSoundEffects?.play()
        }catch{
            //nothing i can do right now
        }
        
    }
    
  

}

