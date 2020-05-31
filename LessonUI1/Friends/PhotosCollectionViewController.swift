//
//  PhotosCollectionViewController.swift
//  LessonUI1
//
//  Created by Александр Павлов on 12.04.2020.
//  Copyright © 2020 Александр Павлов. All rights reserved.
//

import UIKit
import RealmSwift

class PhotosCollectionViewController: UICollectionViewController {
    
    var friend: User!
    var userPhotos: [Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = friend.firstName + " " + friend.lastName
        
        self.loadPhotosData(friend.id, completion: { [weak self] in
            self!.loadData()
            self!.collectionView.reloadData()
        })
        
    }
    
    func loadData() {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)
            print(realm.configuration.fileURL!)
            
            let photos = realm.objects(Photo.self)
            self.userPhotos = Array(photos)
        } catch {
            print(error)
        }
    }
    
    func loadPhotosData(_ id: Int, completion: @escaping () -> Void) {
        VKRequests.getPhotosById(id, completion: { photos in
            
            self.savePhotosData(photos)
            completion()
            
        })
    }
    
    func savePhotosData(_ photos: [Photo]) {
        do {
            let realm = try Realm()
            let oldPhotos = realm.objects(Photo.self)
            
            realm.beginWrite()
            realm.delete(oldPhotos)
            realm.add(photos)
            try realm.commitWrite()
            
        } catch {
            print(error)
        }
        
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
        if userPhoto.image == nil {
            ImageHelper.getImageFromURL(userPhoto.url, completion: { image in
                cell.photo.image = image
                cell.like.likeCount = userPhoto.likes
                cell.like.likeCounter.text = String(cell.like.likeCount)
                
                for i in 0..<self.userPhotos.count {
                    if self.userPhotos[i].id == userPhoto.id {
                        self.userPhotos[i].image = image
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
