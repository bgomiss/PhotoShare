//
//  POST.swift
//  PhotoShareApp
//
//  Created by aycan duskun on 17.01.2023.
//

import Foundation

class POST {
    
    var email: String
    var comment: String
    var image: String
    
    init(email: String, comment: String, image: String) {
        self.email = email
        self.comment = comment
        self.image = image
    }
}
