//
//  Group.swift
//  LessonUI1
//
//  Created by Александр Павлов on 12.04.2020.
//  Copyright © 2020 Александр Павлов. All rights reserved.
//

import UIKit

struct GroupR: Codable {
    var id: Int
    var name: String
    var photo100: String
    
     enum CodingKeys: String, CodingKey {
     case id
        case name
        case photo100 = "photo_100"
    }
}

struct Group {
    var id: Int
    var name: String
    var photo100: String
    var avatar: UIImage = UIImage()
    
    init(_ groupR: GroupR) {
        id = groupR.id
        name = groupR.name
        photo100 = groupR.photo100
    }
}
