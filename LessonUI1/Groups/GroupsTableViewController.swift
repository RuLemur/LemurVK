//
//  GroupsTableViewController.swift
//  LessonUI1
//
//  Created by Александр Павлов on 12.04.2020.
//  Copyright © 2020 Александр Павлов. All rights reserved.
//

import UIKit

class GroupsTableViewController: UITableViewController {
    var groups: [Group] = [
        Group(name: "Pikabu", avatar: UIImage(named: "group_img")!)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(self.openFindView))
        navigationItem.rightBarButtonItem = searchButton
    }
    
    @objc func openFindView() {
        performSegue(withIdentifier: "openSearch", sender: nil)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath)
        cell.textLabel?.text = groups[indexPath.row].name
        cell.imageView?.image = groups[indexPath.row].avatar
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if segue.identifier == "addGroup" {
            let allGroupController = segue.source as! FindGroupsTableViewController
            if let indexPath = allGroupController.tableView.indexPathForSelectedRow {
                let group = allGroupController.groups[indexPath.row]
                if !groups.contains(where: {$0.name == group.name}){
                    groups.append(group)
                }
                tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
