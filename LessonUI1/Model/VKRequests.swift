//
//  VKRequests.swift
//  LessonUI1
//
//  Created by Александр Павлов on 14.05.2020.
//  Copyright © 2020 Александр Павлов. All rights reserved.
//

import UIKit
import Alamofire

struct VKResponse<T:Codable>: Codable {
    let response: RespDict<T>
}

struct RespDict<T:Codable>: Codable {
    let count: Int
    let items: [T]
}

class VKRequests {
    
    static let baseUrl = "https://api.vk.com"
    static let baseParams: Parameters = [
        "access_token": Session.instance.token,
        "v": "5.103",
    ]
    
    static func getFriends(completion: @escaping ([User]) -> Void) {
        let path = "/method/friends.get"
        var params = baseParams
        
        params["user_id"] = Session.instance.userId
        params["fields"] = "photo_100"
        
        let url = baseUrl + path
        
        AF.request(url, parameters: params).responseData {
            response in
            guard let data = response.value else { return }
            
            do {
                var users: [User] = []
                let userRs = try JSONDecoder().decode(VKResponse<UserR>.self, from: data)
                userRs.response.items.forEach({userR in
                    users.append(User(userR))
                })
                completion(users)
            } catch {
                print(error)
            }
        }
        
    }
    
    static func getPhotosById(_ id: Int, completion: @escaping ([Photo]) -> Void) {
        let path = "/method/photos.getAll"
        var params = baseParams
        params["owner_id"] = id
        params["count"] = 10
        params["extended"] = true
        
        let url = baseUrl + path
        AF.request(url, parameters: params).responseData {
            response in
            guard let data = response.value else { return }
            
            
            do {
                var photos: [Photo] = []
                let photosR = try JSONDecoder().decode(VKResponse<PhotosR>.self, from: data)
                photosR.response.items.forEach({photoR in
                    photos.append(Photo(photoR))
                })
                completion(photos)
            } catch {
                print(error)
                
            }
            
        }
    }
    static func geMyGroups(completion: @escaping ([Group]) -> Void) {
        let path = "/method/groups.get"
        var params = baseParams
        params["extended"] = true
        
        let url = baseUrl + path
        
        AF.request(url, parameters: params).responseData {
            response in
            guard let data = response.value else { return }
            
            do {
                var groups: [Group] = []
                let groupRs = try JSONDecoder().decode(VKResponse<GroupR>.self, from: data)
                groupRs.response.items.forEach({groupR in
                    groups.append(Group(groupR))
                })
                completion(groups)
            } catch {
                print(error)
            }
            
        }
    }
    
    static func searchGroups(_ searchString: String, completion: @escaping ([Group]) -> Void){
        let path = "/method/groups.search"
        var params = baseParams
        
        params["q"] = searchString
        
        let url = baseUrl + path
        AF.request(url, parameters: params).responseData {
            response in
            guard let data = response.value else { return }
            
            do {
                var groups: [Group] = []
                let groupRs = try JSONDecoder().decode(VKResponse<GroupR>.self, from: data)
                groupRs.response.items.forEach({groupR in
                    groups.append(Group(groupR))
                })
                completion(groups)
            } catch {
                print(error)
            }
            
        }
        
    }
}
