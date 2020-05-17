//
//  User.swift
//  LessonUI1
//
//  Created by Александр Павлов on 12.04.2020.
//  Copyright © 2020 Александр Павлов. All rights reserved.
//

import UIKit

struct UserR: Codable {
    let id: Int
    let first_name: String
    let last_name: String
    let photo_100: String
//    let avatar: UIImage
//    let photos: [UIImage]
}

struct User {
    let id: Int
    let first_name: String
    let last_name: String
    var photo_100: String = ""
    
    var avatar: UIImage = UIImage()
    var photos: [UIImage] = []
    
    init(_ userR: UserR) {
        id = userR.id
        first_name = userR.first_name
        last_name = userR.last_name
        photo_100 = userR.photo_100
    }

}
