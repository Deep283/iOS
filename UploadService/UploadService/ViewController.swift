//
//  ViewController.swift
//  UploadService
//
//  Created by vinay shinde on 27/02/18.
//  Copyright © 2018 vinay shinde. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MPMediaPickerControllerDelegate{
    
    let controller = UIImagePickerController()
    var imgButton : UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor.cyan
        button.layer.cornerRadius = 10
        button.setTitle("Upload Image", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(imgAction), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    var videoButton : UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor.cyan
        button.layer.cornerRadius = 10
        button.setTitle("Upload video", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(videoAction), for: .touchUpInside)
        return button
    }()
    
    var audioButton : UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor.cyan
        button.layer.cornerRadius = 10
        button.setTitle("Upload audio", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(audioAction), for: .touchUpInside)
        return button
    }()
    
    @objc func imgAction()
    {
        controller.delegate = self
         controller.sourceType  = .photoLibrary
        controller.mediaTypes = ["public.image"]
         present(controller, animated: true, completion: nil)
    }
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        print("you picked \(mediaItemCollection)")
        dismiss(animated: true, completion: nil)
    }
    
    @objc func audioAction()
    {
        let mediaPicker = MPMediaPickerController.self(mediaTypes: MPMediaType.music)
        mediaPicker.delegate = self
        mediaPicker.allowsPickingMultipleItems = false
        self.present(mediaPicker, animated: true, completion: nil)
    }
    
    @objc func videoAction()
    {
        controller.delegate = self
        controller.sourceType = .photoLibrary
        controller.mediaTypes = ["public.movie"]
        present(controller, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        self.view.addSubview(imgButton)
        self.view.addSubview(audioButton)
        self.view.addSubview(videoButton)
        setUpButtons()
        
    }

    func setUpButtons()
    {
        //set up audio button
        audioButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        audioButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        audioButton.widthAnchor.constraint(equalTo: view.widthAnchor,constant: -24).isActive = true
        audioButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //set up image button
        imgButton.bottomAnchor.constraint(equalTo: audioButton.topAnchor, constant: -24).isActive = true
        imgButton.leftAnchor.constraint(equalTo: audioButton.leftAnchor).isActive = true
        imgButton.widthAnchor.constraint(equalTo: view.widthAnchor,constant: -24).isActive = true
        imgButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //set up video button
        videoButton.topAnchor.constraint(equalTo: audioButton.bottomAnchor, constant: 24).isActive = true
        videoButton.leftAnchor.constraint(equalTo: audioButton.leftAnchor).isActive = true
        videoButton.widthAnchor.constraint(equalTo: view.widthAnchor,constant: -24).isActive = true
        videoButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

