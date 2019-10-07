
//
//  createSnapViewController.swift
//  snapfan.emily
//
//  Created by 野崎絵未里 on 2019/10/08.
//  Copyright © 2019 emily.com. All rights reserved.
//

import UIKit
import FirebaseStorage

class createSnapViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate  {
    
    @IBOutlet weak var noteText: UITextField!
    @IBOutlet weak var image: UIImageView!
    var imagePicker = UIImagePickerController()
    var imageName = "\(NSUUID().uuidString).jpeg"
    var imageURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func next(_ sender: Any) {
        let imagesFolder = Storage.storage().reference().child("images")
        if let image = image.image {
            
            
            if let imageData = image.jpegData(compressionQuality: 0.1) {
                imagesFolder.child(imageName).putData(imageData, metadata: nil) {(metaData, error) in
                    if let rror = error {
                        print(error)
                    } else {
                        
                        imagesFolder.child(self.imageName).downloadURL { (url, error) in
                            if let imageURL = url?.absoluteString{
                                
                                self.imageURL = imageURL
                                
                                self.performSegue(withIdentifier: "moveToSend", sender: nil)
                            }
                        }
                    }
                }
            }
        }
    }
        @IBAction func cameraTab(_ sender: Any) {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        }
        @IBAction func albumTab(_ sender: Any) {
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }
        
        //    func imagePickercontroller(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo
        //        info: [String : Any]) {
        //        if let selectedImage = info[UIImagePickerControllerOriginalImage] {
        //            imageView.image = selectedImage
        //        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                image.image = selectedImage
            }
        }
        
        
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
        
        
    }

