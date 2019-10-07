//
//  AuthViewController.swift
//  snapfan.emily
//
//  Created by 野崎絵未里 on 2019/10/08.
//  Copyright © 2019 emily.com. All rights reserved.
///Users/EMILY/Documents/LIT_iPhone/APP/emilyApp_daily/snapfan.emily/snapfan.emily/AuthViewController.swift

import UIKit
import FirebaseAuth

class AuthViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    var logInMode = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logIn(_ sender: Any) {
        if let email = emailText.text {
            if let password = password.text {
                if logInMode {
                    Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                        
                        
                        if error == nil {
                            print("User signed in")
                            
                           //何かの中？でやるときは、self.をつける。多分自分の中だからかな。
                            self.performSegue(withIdentifier: "authsuccess", sender: nil)
                        } else {
                            //print(error)
                        }
                    }
                } else {
                    Auth.auth().createUser(withEmail: email, password: password) { (result, error)
                        in
                        if error == nil {
                            print("User created")
                        } else {
                            //print(error)
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func signUp(_ sender: Any) {
        if logInMode {
            logInMode = false
            topButton.setTitle("sign up", for: .normal)
            bottomButton.setTitle("switch to log in", for: .normal)
        } else {
            logInMode = true
            topButton.setTitle("log in", for: .normal)
            bottomButton.setTitle("switch to sign up", for: .normal)
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
