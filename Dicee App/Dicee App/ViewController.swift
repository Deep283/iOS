//
//  ViewController.swift
//  Dicee App
//
//  Created by vinay shinde on 30/06/18.
//  Copyright © 2018 vinay shinde. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var randomDiceNum1 = 0
    var randomDiceNum2 = 0
    
    @IBOutlet weak var diceImageView1: UIImageView!
    
    @IBOutlet weak var diceImageView2: UIImageView!
    
    let diceArray = [#imageLiteral(resourceName: "dice1"), #imageLiteral(resourceName: "dice2"), #imageLiteral(resourceName: "dice3"), #imageLiteral(resourceName: "dice4"), #imageLiteral(resourceName: "dice5"), #imageLiteral(resourceName: "dice6")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDiceImages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func rollTappedAction(_ sender: UIButton) {
        animate(imageView: diceImageView1, images: diceArray)
        animate(imageView: diceImageView2, images: diceArray)
        updateDiceImages()
    }
    
    func animate(imageView: UIImageView, images: [UIImage]) {
        imageView.animationImages = images
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = 1
        imageView.startAnimating()
    }
    func updateDiceImages(){
        randomDiceNum1 = Int(arc4random_uniform(6))
        randomDiceNum2 = Int(arc4random_uniform(6))
        
        diceImageView1.image = diceArray[randomDiceNum1]
        diceImageView2.image = diceArray[randomDiceNum2]
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        animate(imageView: diceImageView1, images: diceArray)
        animate(imageView: diceImageView2, images: diceArray)
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        updateDiceImages()
    }
}

