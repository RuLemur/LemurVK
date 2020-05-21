//
//  ImageHelper.swift
//  LessonUI1
//
//  Created by Александр Павлов on 17.05.2020.
//  Copyright © 2020 Александр Павлов. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class ImageHelper {
    static func getImageFromURL(_ url: String, completion: @escaping (UIImage) -> Void) {
        AF.request(url).responseImage { response in
 
            if case .success(let image) = response.result {
                print("load image \(url)")
               completion(image)
            }
        }
    }
}
