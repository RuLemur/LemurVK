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
    var userPhotos: [Photos] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = friend.first_name + " " + friend.last_name
        
        VKRequests.getPhotosById(friend.id, completion: { photos in
            self.userPhotos = photos
            self.collectionView.reloadData()
        })
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return userPhotos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendPhotoCell", for: indexPath) as! FriendPhotoCell
        let userPhoto = userPhotos[indexPath.row]
        if userPhoto.url != "" {
            ImageHelper.getImageFromURL(userPhoto.url, completion: { image in
                cell.photo.image = image
                cell.like.likeCount = userPhoto.likes
                cell.like.likeCounter.text = String(cell.like.likeCount)
                
                for i in 0..<self.userPhotos.count {
                    if self.userPhotos[i].id == userPhoto.id {
                        self.userPhotos[i].image = image
                        self.userPhotos[i].url = ""
                        break
                    }
                }
            })
        }
        return cell
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let fullPhotoController = segue.destination as? FullPhotoViewController {
            if let indexPath = collectionView.indexPathsForSelectedItems {
                fullPhotoController.selectedPhoto = indexPath[0].row
                fullPhotoController.userPhotos = userPhotos
                
            }
        }
        
    }
    
    
    
}
