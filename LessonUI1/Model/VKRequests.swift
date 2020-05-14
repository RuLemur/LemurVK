//
//  VKRequests.swift
//  LessonUI1
//
//  Created by Александр Павлов on 14.05.2020.
//  Copyright © 2020 Александр Павлов. All rights reserved.
//

import UIKit
import Alamofire

class VKRequests {
    
    static let baseUrl = "https://api.vk.com"
    static let baseParams: Parameters = [
        "access_token": Session.instance.token,
        "v": "5.103",
    ]
    
    static func getFriends() {
        let path = "/method/friends.get"
        var params = baseParams
        
        params["user_id"] = Session.instance.userId
        params["fields"] = "nickname"
        
        let url = baseUrl + path
        AF.request(url, method: .get, parameters: params).responseJSON { response in
            print(response.value as Any)
//            return response.value!
            
        }
    
    }
    
    static func getPhotosById(_ id: Int) {
        let path = "/method/photos.getAll"
        var params = baseParams
        params["owner_id"] = id
        
        let url = baseUrl + path
        AF.request(url, method: .get, parameters: params).responseJSON { response in
            print(response.value as Any)
        }
    
    }
    
    static func geMyGroups() {
           let path = "/method/groups.get"
           let params = baseParams
        
           let url = baseUrl + path
           AF.request(url, method: .get, parameters: params).responseJSON { response in
            print(response.value as Any)
           }
       
       }
    
    static func searchGroups(_ searchString: String){
        let path = "/method/groups.search"
        var params = baseParams
        
        params["q"] = searchString
        
        let url = baseUrl + path
        AF.request(url, method: .get, parameters: params).responseJSON { response in
            print(response.value as Any)
        }

    }
}
