//
//  Photos.swift
//  LessonUI1
//
//  Created by Александр Павлов on 18.05.2020.
//  Copyright © 2020 Александр Павлов. All rights reserved.
//

import UIKit
import RealmSwift

struct PhotosR: Codable {
    let id: Int
    var ownerId: Int
    var sizes: [Sizes]
    let likes: Likes
    
     enum CodingKeys: String, CodingKey {
        case id
        case ownerId = "owner_id"
        case sizes
        case likes
    }
    
}

class Photos: Object {
    @objc dynamic let id: Int
    @objc dynamic var url: String!
    @objc dynamic var ownerId: Int
    @objc dynamic var image: UIImage = UIImage()
    @objc dynamic let likes: Int
    
    init(_ photosR: PhotosR) {
        id = photosR.id
        ownerId = photosR.ownerId
        likes = photosR.likes.count
        
        for size in photosR.sizes {
            if size.type == "r" {
                url = size.url
                break
            } else {
                url = size.url
            }
        }
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
}

struct Sizes: Codable {
    let url: String
    let type: String
}

struct Likes: Codable {
    let count: Int
}
