//
//  ViewController.swift
//  PhotoShareApp
//
//  Created by aycan duskun on 14.01.2023.
//

import UIKit
import Firebase


class ViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { [weak self] (authResult, error) in
                
                if error != nil { self?.errorMessage(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error! Try again")
                    
                } else {
                    
                    self?.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else {
                self.errorMessage(titleInput: "Error", messageInput: "Enter email and password")
            }
        }
    

            
            @IBAction func signupTapped(_ sender: UIButton) {
                
                if emailTextField.text != "" && passwordTextField.text != "" {
                    
                    //Register
                    
                    Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authdataresult, error) in
                        
                        if error != nil {
                            
                            self.errorMessage(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error, try again!")
                            
                        } else {
                            self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                        }
                        
                    }
                }else {
                    errorMessage(titleInput: "Error", messageInput: "Enter Email and Password")
                }
            }
            
            func errorMessage(titleInput: String, messageInput: String) {
                
                let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
                
                let okButton = UIAlertAction(title: "OK", style: .default)
                
                alert.addAction(okButton)
                self.present(alert, animated: true)
                
            }
}
            
        
        
    


