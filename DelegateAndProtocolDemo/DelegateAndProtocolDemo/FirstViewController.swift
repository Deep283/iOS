//
//  ViewController.swift
//  DelegateAndProtocolDemo
//
//  Created by vinay shinde on 11/07/18.
//  Copyright © 2018 vinay shinde. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, SecondViewDelegate {
    func dataRecieved(text: String) {
        label.text = text
    }
    
    var text = ""

    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        label.text = text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "ChangeToSecond", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ChangeToSecond" {
            let secondVC = segue.destination as! SecondViewController
            
            secondVC.delegate = self
            
            secondVC.text = textField.text!
        }
        
    }
    
}

