//
//  viewSnapViewController.swift
//  snapfan.emily
//
//  Created by 野崎絵未里 on 2019/10/09.
//  Copyright © 2019 emily.com. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage
import SDWebImage

class viewSnapViewController: UIViewController {
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var image: UIImageView!
    
    var snapshot : DataSnapshot?
    var imageName = ""
    var snapID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let snapshot = snapshot {
            if let snapDictionary = snapshot.value as? NSDictionary {
                if let imageName = snapDictionary["imageName"] as? String {
                    if let imageURL = snapDictionary["imageURL"] as? String {
                        if let message = snapDictionary["message"] as? String {
                            messageLabel.text = message
                            if let url = URL(string: imageURL) {
                                image.sd_setImage(with: url, completed: nil)
                            }
                            self.imageName = imageName
                            snapID = snapshot.key
                             
                        }
                    }
                }
            }
            
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let uid = Auth.auth().currentUser?.uid {
            Database.database().reference().child("users").child(uid).child("snaps").child(snapID).removeValue()
            Storage.storage().reference().child("images").child(imageName).delete(completion: nil)
             
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
