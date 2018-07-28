//
//  ViewController.swift
//  STFrameDemo
//
//  Created by vinay shinde on 18/12/17.
//  Copyright © 2017 vinay shinde. All rights reserved.
//

import UIKit
import STKit
import Alamofire

@IBDesignable class ViewController: STBaseViewController {

    var courses = [Course]()
    var stButton: STButton = STButton(x1: 100, y1: 100)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stButton.setTitle("STButton", for: .normal)
        stButton.layer.cornerRadius = stButton.bounds.width/6
        stButton.backgroundColor = UIColor.blue
        stButton.action = {
            Alamofire.request("/Users/vinayshinde/Desktop/Deepak/Project1/Deal1/").responseJSON { response in
               if let json = response.data {
                    do
                    {
                        self.courses = try JSONDecoder().decode([Course].self, from: json)
                    }catch {}
                for course in self.courses {
                    print("ID:",course.id ?? -1,"\nName:",course.name ?? "nil","\nLink:",course.link ?? "nil","\nImageUrl:",course.imageUrl ?? "nil")
                }
                }
            }
        }
        self.view.addSubview(stButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//"https://api.letsbuildthatapp.com/jsondecodable/courses_missing_fields"
