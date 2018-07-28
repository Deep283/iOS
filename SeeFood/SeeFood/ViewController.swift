//
//  ViewController.swift
//  SeeFood
//
//  Created by vinay shinde on 18/07/18.
//  Copyright © 2018 vinay shinde. All rights reserved.
//

import UIKit
import Vision
import CoreML

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let userPickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            imageView.image = userPickedImage
            
            guard let ciimage = CIImage(image: userPickedImage) else{
                fatalError("Could not convert UIImage into CIImage")
            }
            detect(image: ciimage)
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }

    func detect(image: CIImage) {
        
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("Loading CoreML model failed")
        }
        let request = VNCoreMLRequest(model: model) { (request, error) in
            
            guard let results = request.results as? [VNClassificationObservation] else{
                fatalError("Model failed to process image")
            }
            if (results.first?.identifier.contains("hotdog"))! {
                self.navigationItem.title = "Hotdog!"
            }
            else{
                self.navigationItem.title = "Not Hotdog!"
            }
        }
        let handler = VNImageRequestHandler(ciImage: image)
        
        do{
            try handler.perform([request])
        }
        catch{
            print(error)
        }
    }
    
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        
        present(imagePicker, animated: true, completion: nil)
    }
}

