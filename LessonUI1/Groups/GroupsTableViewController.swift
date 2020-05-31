//
//  GroupsTableViewController.swift
//  LessonUI1
//
//  Created by Александр Павлов on 12.04.2020.
//  Copyright © 2020 Александр Павлов. All rights reserved.
//

import UIKit
import RealmSwift

class GroupsTableViewController: UITableViewController {
    var groups: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(self.openFindView))
        navigationItem.rightBarButtonItem = searchButton
        
        self.loadGroupsData {[weak self] in
            self!.loadData()
            self!.tableView.reloadData()
        }
        
    }
    
    func loadData() {
        do {
            let realm = try Realm()
            print(realm.configuration.fileURL!)
            let groups = realm.objects(Group.self)
            self.groups = Array(groups)
        } catch {
            print(error)
        }
    }
    
    func loadGroupsData(completion: @escaping () -> Void) {
        VKRequests.geMyGroups(completion: { groups in
            
            self.saveGroupsData(groups)
            completion()
            
        })
    }
    
    func saveGroupsData(_ groups: [Group]) {
        do {
            let realm = try Realm()
            let oldGroups = realm.objects(Group.self)
            
            realm.beginWrite()
            realm.delete(oldGroups)
            realm.add(groups)
            try realm.commitWrite()
            
        } catch {
            print(error)
        }
        
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
        
        if groups[indexPath.row].avatar == nil {
            ImageHelper.getImageFromURL(groups[indexPath.row].photo100, completion: { image in
                cell.imageView?.image = image
                for i in 0..<self.groups.count {
                    if self.groups[i].id == self.groups[indexPath.row].id {
                        self.groups[i].avatar = image
                        break
                    }
                }
                
            })
        } else {
            cell.imageView?.image = groups[indexPath.row].avatar
        }
        
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
