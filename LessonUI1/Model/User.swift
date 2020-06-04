//
//  User.swift
//  LessonUI1
//
//  Created by Александр Павлов on 12.04.2020.
//  Copyright © 2020 Александр Павлов. All rights reserved.
//

import UIKit
import RealmSwift

struct UserR: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let photo100: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo100 = "photo_100"
    }
}

class User: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var photo100: String = ""
    
    var avatar: UIImage? = nil
    var photos: [UIImage] = []
    
    init(_ userR: UserR) {
        id = userR.id
        firstName = userR.firstName
        lastName = userR.lastName
        photo100 = userR.photo100
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    required init() {
        return
    }
    
}
