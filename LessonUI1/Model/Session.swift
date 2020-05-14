//
//  Session.swift
//  LessonUI1
//
//  Created by Александр Павлов on 10.05.2020.
//  Copyright © 2020 Александр Павлов. All rights reserved.
//

import UIKit

class Session{
    
    static let instance = Session()
    
    private init(){}
    
    var token: String = ""
    var userId: Int = 0
}
