//
//  SettingsViewController.swift
//  PhotoShareApp
//
//  Created by aycan duskun on 15.01.2023.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func signoutTapped(_ sender: UIButton) {
        
        do{
           try Auth.auth().signOut()
            performSegue(withIdentifier: "toVC", sender: nil)
        }catch{
            print("error")
        }
        
    }
    
}
