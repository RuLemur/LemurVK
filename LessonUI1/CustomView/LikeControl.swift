//
//  LikeControl.swift
//  LessonUI1
//
//  Created by Александр Павлов on 14.04.2020.
//  Copyright © 2020 Александр Павлов. All rights reserved.
//

import UIKit

class LikeControl: UIControl {
    var isLike: Bool = false
    var likeCount: Int = 35
    let like = UIImageView()
    let likeCounter = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    func setupView() {
        self.backgroundColor = .none
        like.image = UIImage(named: "empty-heart")
        like.frame = CGRect(x: self.frame.width/1.8, y: 0, width: self.frame.height, height: self.frame.height)
        
        likeCounter.center = self.center
        likeCounter.textAlignment = .center
        likeCounter.font = UIFont.systemFont(ofSize: self.frame.height)
        likeCounter.text = String(likeCount)
        likeCounter.frame = CGRect(x: 0, y: 0, width: self.frame.width/2, height: self.frame.height)
        self.addSubview(like)
        self.addSubview(likeCounter)
        
        
        self.addTarget(self, action: #selector(pressLike), for: .touchUpInside)
        
    }
    
    @objc private func pressLike() {
        isLike = !isLike
        if isLike {
            likeCount = likeCount + 1
            likeCounter.text = String(likeCount)
            like.image = UIImage(named: "filled-heart")
        } else {
            likeCount = likeCount - 1
            likeCounter.text = String(likeCount)
            like.image = UIImage(named: "empty-heart")
        }
        
        self.setNeedsDisplay()
    }
    
    func likeAnimate(){
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.8
        animation.toValue = 1
        animation.stiffness = 200
        animation.mass = 2
        animation.duration = 1
        animation.beginTime = CACurrentMediaTime()
        animation.fillMode = CAMediaTimingFillMode.backwards
        self.like.layer.add(animation, forKey: nil)
        
    }
}





