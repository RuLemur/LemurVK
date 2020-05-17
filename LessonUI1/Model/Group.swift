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
    var photo_100: String
}

struct Group {
    var id: Int
    var name: String
    var photo_100: String
    var avatar: UIImage = UIImage()
    
    init(_ groupR: GroupR) {
        id = groupR.id
        name = groupR.name
        photo_100 = groupR.photo_100
    }
}
