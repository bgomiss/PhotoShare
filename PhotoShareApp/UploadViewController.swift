//
//  UploadViewController.swift
//  PhotoShareApp
//
//  Created by aycan duskun on 15.01.2023.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import Firebase

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var commentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageSelection))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func imageSelection() {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    @IBAction func uploadTapped(_ sender: UIButton) {
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            
            let uuid = UUID().uuidString
            let imageReference = mediaFolder.child("\(uuid).jpg")
            
            imageReference.putData(data) { storageMetaData, error in
                
                if error != nil {
                    self.errorMessage(title: "Error", message: error?.localizedDescription ?? "Try Again!")
                    
                } else {
                    imageReference.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                           
                            if let imageUrl = imageUrl {
                                let firestoreDatabase = Firestore.firestore()
                                                         
                                let firestorePost = ["imageUrl" : imageUrl, "comment" : self.commentTextField.text!, "email" : Auth.auth().currentUser!.email!, "Date" : FieldValue.serverTimestamp()] as [String : Any]
                                                         
                                firestoreDatabase.collection("POST").addDocument(data: firestorePost) {
                                    (error) in
                                    
                                    if error != nil {
                                        self.errorMessage(title: "Error", message: error?.localizedDescription ?? "Error! Try Again!")
                                    } else {
                                        
                                    }
                                }
                            }
                         
                        }
                    }
                }
            }
        }
        
    }
    func errorMessage(title:String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }

}
