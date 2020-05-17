//
//  FindGroupsTableViewController.swift
//  LessonUI1
//
//  Created by Александр Павлов on 12.04.2020.
//  Copyright © 2020 Александр Павлов. All rights reserved.
//

import UIKit

class FindGroupsTableViewController: UITableViewController {
    
    var groups: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        VKRequests.searchGroups("Photo", completion: { groups in
            self.groups = groups
            self.tableView.reloadData()
            
        })
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
        
        if groups[indexPath.row].photo_100 != "" {
            ImageHelper.getImageFromURL(groups[indexPath.row].photo_100, completion: { image in
                cell.imageView?.image = image
                for i in 0..<self.groups.count {
                    if self.groups[i].id == self.groups[indexPath.row].id {
                        self.groups[i].avatar = image
                        self.groups[i].photo_100 = ""
                        break
                    }
                }

            })
        } else {
            cell.imageView?.image = groups[indexPath.row].avatar
        }
        return cell
    }
    
    

}
