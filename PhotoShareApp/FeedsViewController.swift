//
//  FeedsViewController.swift
//  PhotoShareApp
//
//  Created by aycan duskun on 15.01.2023.
//

import UIKit
import Firebase
import FirebaseFirestore
import SDWebImage

class FeedsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    

    var postArray = [POST]()
    //    var emailArray = [String]()
//    var commentArray = [String]()
//    var imageArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        fetchFirebaseData()
    }
    
    func fetchFirebaseData() {
        
        let firestoreDatabase = Firestore.firestore()
        firestoreDatabase.collection("POST").order(by: "Date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    
//                    self.emailArray.removeAll(keepingCapacity: false)
//                    self.commentArray.removeAll(keepingCapacity: false)
//                    self.imageArray.removeAll(keepingCapacity: false)
                    self.postArray.removeAll()
                    
                    for document in snapshot!.documents {
                        if let imageURL = document.get("imageUrl") as? String {
                            
                            if let comment = document.get("comment") as? String {
                                                        
                                if let email = document.get("email") as? String {
                                    let post = POST(email: email, comment: comment, image: imageURL)
                                    self.postArray.append(post)
                                                       }
                                                    }
                                                }
                                        }
                    
                    self.tableView.reloadData()
                }
                
            }
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.emailText.text = postArray[indexPath.row].email
        cell.commentText.text = postArray[indexPath.row].comment
        cell.postImageView.sd_setImage(with: URL(string: self.postArray[indexPath.row].image))
        return cell
    }
}
