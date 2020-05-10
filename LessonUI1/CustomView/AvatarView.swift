//
//  AvatarView.swift
//  LessonUI1
//
//  Created by Александр Павлов on 14.04.2020.
//  Copyright © 2020 Александр Павлов. All rights reserved.
//

import UIKit

@IBDesignable
class AvatarView: UIControl {
    

    var avatar: UIImage = UIImage(named: "peng")! {
        didSet {
            self.setupView(avatar)
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat = .zero {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor = .black {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView(avatar)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView(avatar)
    }
    
    private func setupView(_ avatar: UIImage) {
        let sizeFrame = self.frame
        self.backgroundColor = .none
        
        let avatarView = UIImageView()
        avatarView.frame = CGRect(x: 5, y: 5, width: sizeFrame.width, height: sizeFrame.height )
        avatarView.image = avatar
        avatarView.layer.cornerRadius = sizeFrame.height/2
        avatarView.clipsToBounds = true
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize(width: 5,height: 7)
        self.layer.cornerRadius = sizeFrame.height/2
        
        self.addSubview(avatarView)
    }
    
}
