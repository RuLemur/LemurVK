//
//  LoadingView.swift
//  LessonUI1
//
//  Created by Александр Павлов on 27.04.2020.
//  Copyright © 2020 Александр Павлов. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    @IBOutlet weak var dot1: UIView!
    @IBOutlet weak var dot2: UIView!
    @IBOutlet weak var dot3: UIView!
     
    override func awakeFromNib() {
        super.awakeFromNib()
        dot1.layer.cornerRadius = dot1.frame.height / 2
        dot2.layer.cornerRadius = dot2.frame.height / 2
        dot3.layer.cornerRadius = dot3.frame.height / 2
    }
    
}
