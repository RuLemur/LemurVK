//
//  Photos.swift
//  LessonUI1
//
//  Created by Александр Павлов on 18.05.2020.
//  Copyright © 2020 Александр Павлов. All rights reserved.
//

import UIKit


struct PhotosR: Codable {
    let id: Int
    var owner_id: Int
    var sizes: [Sizes]
}

struct Photos {
    let id: Int
    var url: String!
    var owner_id: Int
    var image: UIImage = UIImage()
    
    init(_ photosR: PhotosR) {
        id = photosR.id
        owner_id = photosR.owner_id
        
        for size in photosR.sizes {
            if size.type == "r" {
                url = size.url
                break
            } else {
                url = size.url
            }
        }
    }
}

struct Sizes: Codable {
    let url: String
    let type: String
}
