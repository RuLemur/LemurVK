//
//  FriendPhotoCell.swift
//  LessonUI1
//
//  Created by Александр Павлов on 12.04.2020.
//  Copyright © 2020 Александр Павлов. All rights reserved.
//

import UIKit

class FriendPhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var like: LikeControl!
    @IBOutlet weak var photo: UIImageView!
    
    @IBAction func likeClick(_ sender: Any) {
        self.like.likeAnimate()
    }
}
