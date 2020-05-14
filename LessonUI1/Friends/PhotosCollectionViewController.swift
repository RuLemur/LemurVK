//
//  PhotosCollectionViewController.swift
//  LessonUI1
//
//  Created by Александр Павлов on 12.04.2020.
//  Copyright © 2020 Александр Павлов. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    
    var friend: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = friend.name
        
        VKRequests.instance.getPhotosById(Session.instance.userId)
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return friend.photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendPhotoCell", for: indexPath) as! FriendPhotoCell
        cell.photo.image = friend.photos[indexPath.row]
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let fullPhotoController = segue.destination as? FullPhotoViewController {
            if let indexPath = collectionView.indexPathsForSelectedItems {
                fullPhotoController.selectedPhoto = indexPath[0].row
                fullPhotoController.friend = friend
            }
        }
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendPhotoCell", for: collectionView!.indexPathsForSelectedItems![0]) as! FriendPhotoCell
//        let image = UIImageView()
//                view.addSubview(image)
//        image.frame = cell.photo.frame
//        image.image = cell.photo.image
//
//        UIView.animate(withDuration: 0.3, animations: {
//            let transform = CGAffineTransform(scaleX: 2, y: 2)
//            image.transform = transform
//        }, completion: { _ in
//            self.performSegue(withIdentifier: "openPhoto", sender: sender)
//        })
    }
    
    
    
}
