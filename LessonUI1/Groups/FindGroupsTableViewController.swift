//
//  FindGroupsTableViewController.swift
//  LessonUI1
//
//  Created by Александр Павлов on 12.04.2020.
//  Copyright © 2020 Александр Павлов. All rights reserved.
//

import UIKit

class FindGroupsTableViewController: UITableViewController {
    
    let groups = [
        Group(name: "Pikabu", avatar: UIImage(named: "group_img")!),
        Group(name: "VK", avatar: UIImage(named: "group_img")!),
        Group(name: "Girls", avatar: UIImage(named: "group_img")!),
        Group(name: "Cats", avatar: UIImage(named: "group_img")!),
        Group(name: "Video", avatar: UIImage(named: "group_img")!),
        Group(name: "Anime", avatar: UIImage(named: "group_img")!),
        Group(name: "iOS", avatar: UIImage(named: "group_img")!),
        Group(name: "Sport", avatar: UIImage(named: "group_img")!),
        Group(name: "BMW", avatar: UIImage(named: "group_img")!)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        VKRequests.instance.searchGroups("Photo")
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allGroup", for: indexPath)
        cell.textLabel?.text = groups[indexPath.row].name
        cell.imageView?.image = groups[indexPath.row].avatar
        
        return cell
    }
    
    

}
