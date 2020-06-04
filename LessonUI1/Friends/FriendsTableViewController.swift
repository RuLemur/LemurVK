//
//  ContactsTableViewController.swift
//  LessonUI1
//
//  Created by Александр Павлов on 12.04.2020.
//  Copyright © 2020 Александр Павлов. All rights reserved.
//

import UIKit
import RealmSwift

class FriendsTableViewController: UITableViewController {
    
    var friends: [User] = []
//    let observer: NotificationCenter?
    
    var filteredFriends = [User]() {
        didSet {
            tableView.reloadData()
        }
    }
    var friendsDictionary = [String: [User]]() {
        didSet {
            friends = friendsDictionary.flatMap {$0.value}.sorted {$0.firstName < $1.firstName }
            tableView.reloadData()
        }
    }
    var friendSectionTitles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadFriendsData { [weak self] in
            self!.loadData()
            self!.tableView.reloadData()
        }
        
    }
    
    func loadData() {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)
            print(realm.configuration.fileURL!)
            
            let friends = realm.objects(User.self)
            self.friends = Array(friends)
            self.friendsDictionary = Dictionary(grouping: self.friends, by: { String($0.lastName.prefix(1)) })
            self.friendSectionTitles = [String](self.friendsDictionary.keys)
            self.friendSectionTitles = self.friendSectionTitles.sorted(by: {$0 < $1})
        } catch {
            print(error)
        }
    }
    
    func loadFriendsData(completion: @escaping () -> Void) {
        VKRequests.getFriends(completion: { users in
            
            self.saveFriendsData(users)
            completion()
            
        })
    }
    
    func saveFriendsData(_ friends: [User]) {
        do {
            let realm = try Realm()
            let oldFriends = realm.objects(User.self)
            
            realm.beginWrite()
            realm.delete(oldFriends)
            realm.add(friends)
            try realm.commitWrite()
            
        } catch {
            print(error)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let photosController = segue.destination as? PhotosCollectionViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                let friend = friendsDictionary[friendSectionTitles[indexPath.section]]![indexPath.row]
                photosController.friend = friend
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return filteredFriends.isEmpty ? friendSectionTitles.count : 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredFriends.isEmpty {
            let friendKey = friendSectionTitles[section]
            return friendsDictionary[friendKey]?.count ?? 0
        } else {
            return filteredFriends.count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return filteredFriends.isEmpty ? friendSectionTitles[section] : nil
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        var friend: User? = nil
        if filteredFriends.isEmpty {
            let friendKey = friendSectionTitles[indexPath.section]
            friend = friendsDictionary[friendKey]?[indexPath.row]
        } else {
            friend = filteredFriends[indexPath.row]
        }
        
        cell.name.text = friend!.firstName + " " + friend!.lastName
        
        if friend!.avatar == nil {
            ImageHelper.getImageFromURL(friend!.photo100, completion: { image in
                friend!.avatar = image
                cell.avatar.avatar = image
                for i in 0..<self.friends.count {
                    if self.friends[i].id == friend!.id {
                        self.friends[i].avatar = image
                        break
                    }
                }

                for (key, group) in self.friendsDictionary {
                    for i in 0..<group.count {
                        if group[i].id == friend!.id {
                            self.friendsDictionary[key]![i].avatar = image
                            break
                        }
                    }
                }
            })
        } else {
            cell.avatar.avatar = friend!.avatar!
        }
        return cell
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return filteredFriends.isEmpty ? friendSectionTitles : nil
    }
    
}

extension FriendsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            clearSearch(searchBar)
            return
        }
        filteredFriends = friends.filter {$0.firstName.lowercased().contains(searchText.lowercased())}
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func clearSearch(_ searchBar: UISearchBar) {
        searchBar.text = nil
        view.endEditing(true)
        filteredFriends = [User]()
    }
}
