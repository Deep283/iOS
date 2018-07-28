//
//  SecondViewController.swift
//  DelegateAndProtocolDemo
//
//  Created by vinay shinde on 11/07/18.
//  Copyright © 2018 vinay shinde. All rights reserved.
//

import UIKit

protocol SecondViewDelegate {
    func dataRecieved(text: String)
}

class SecondViewController: UIViewController {
    
    var text = ""
    
    var delegate: SecondViewDelegate?

    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        label.text = text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        delegate?.dataRecieved(text: textField.text!)
        
        dismiss(animated: true, completion: nil)
        
    }
    
}
