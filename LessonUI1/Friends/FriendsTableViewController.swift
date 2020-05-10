//
//  ContactsTableViewController.swift
//  LessonUI1
//
//  Created by Александр Павлов on 12.04.2020.
//  Copyright © 2020 Александр Павлов. All rights reserved.
//

import UIKit


class FriendsTableViewController: UITableViewController {
   
    var friends = [
        User(name: "Rita Vrataski", avatar: UIImage(named: "rita1")!, photos: [UIImage(named: "rita1")!, UIImage(named: "rita2")!, UIImage(named: "rita3")!]),
        User(name: "Keanu Charles Reeves", avatar: UIImage(named: "keanu1")!, photos: [UIImage(named: "keanu1")!, UIImage(named: "keanu2")!, UIImage(named: "keanu3")!, UIImage(named: "keanu4")!,  UIImage(named: "keanu5")!,  UIImage(named: "keanu6")!]),
        User(name: "Obi Van Kenobi", avatar: UIImage(named: "kenobi1")!, photos: [UIImage(named: "kenobi1")!]),
        User(name: "Magister Yoda", avatar: UIImage(named: "yoda1")!, photos: [UIImage(named: "yoda1")!]),
        User(name: "Zoydberg", avatar: UIImage(named: "zoydberg1")!, photos: [UIImage(named: "zoydberg1")!]),
        User(name: "Sasha Gray", avatar: UIImage(named: "gray1")!, photos: [UIImage(named: "gray1")!]),
        User(name: "Fry", avatar: UIImage(named: "fry1")!, photos: [UIImage(named: "fry1")!]),
        User(name: "Bender", avatar: UIImage(named: "bender1")!, photos: [UIImage(named: "bender1")!]),
        User(name: "Wacky", avatar: UIImage(named: "wacky1")!, photos: [UIImage(named: "wacky1")!]),
        User(name: "Ja Ja Binks", avatar: UIImage(named: "binks1")!, photos: [UIImage(named: "binks1")!])
    ]
    
    var filteredFriends = [User]() {
        didSet {
            tableView.reloadData()
        }
    }
    var friendsDictionary = [String: [User]]() {
        didSet {
            friends = friendsDictionary.flatMap {$0.value}.sorted {$0.name < $1.name }
            tableView.reloadData()
        }
    }
    var friendSectionTitles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendsDictionary = Dictionary(grouping: friends, by: { String($0.name.prefix(1)) })
        friendSectionTitles = [String](friendsDictionary.keys)
        friendSectionTitles = friendSectionTitles.sorted(by: {$0 < $1})
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
        
        cell.name.text = friend!.name
        cell.avatar.avatar = friend!.avatar
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
        filteredFriends = friends.filter {$0.name.lowercased().contains(searchText.lowercased())}
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
