//
//  FullPhotoViewController.swift
//  LessonUI1
//
//  Created by Александр Павлов on 26.04.2020.
//  Copyright © 2020 Александр Павлов. All rights reserved.
//

import UIKit

class FullPhotoViewController: UIViewController {
    
    var friend: User!
    var selectedPhoto = 0
    
    @IBOutlet var panGest: UIPanGestureRecognizer!
    
    var animation: UIViewPropertyAnimator!
    
    var leftImage = UIImageView()
    var centerImage = UIImageView()
    var rightImage = UIImageView()
    
    var isRightSwipe = false
    var isDirectionChanged = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setImage()
        
    }
    var startTap: CGFloat!
    
    @IBAction func pan(_ sender: UIPanGestureRecognizer) {
        let velocity = sender.velocity(in: self.view).x
        
        
        switch sender.state {
        case .began:
            self.startTap = panGest.location(in: self.view).x
            isRightSwipe = velocity<0
            createAnimation(isRightSwipe)
        case .changed:
            let translationX = sender.translation(in: self.view).x
            if isRightSwipe == (translationX < 0) {
                isDirectionChanged = false
            } else {
                isDirectionChanged = true
            }
            
            if isDirectionChanged {
                isDirectionChanged = false
                isRightSwipe = !isRightSwipe
                createAnimation(isRightSwipe)
                
            }
            let currentTap = panGest.location(in: self.view).x
            self.animation.fractionComplete = abs((currentTap / self.view.frame.width) - (self.startTap / self.view.frame.width))
        case .ended:
            self.selectedPhoto += isRightSwipe ? 1 : -1
            if self.selectedPhoto < 0 || self.selectedPhoto >= self.friend.photos.count {
                self.cancelAnimation()
                self.selectedPhoto += self.isRightSwipe ? -1 : +1
                
                break
            } else {
                if self.animation.fractionComplete < 0.4 {
                    cancelAnimation()
                    self.selectedPhoto += self.isRightSwipe ? -1 : +1
//                    break
                } else {
                    self.animation.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                    self.animation.addCompletion({ _ in
                        self.setImage()
                    })
                }
            }
            
        default:
            break
        }
    }
    
    func cancelAnimation() {
        self.animation.stopAnimation(false)
        self.animation.finishAnimation(at: .start)
        self.animation.addCompletion({_ in
            self.leftImage.transform = .identity
            self.rightImage.transform = .identity
            self.centerImage.transform = .identity
        })
        

    }
    
    func createAnimation(_ isRightDirection: Bool){
        if self.animation != nil {
            self.animation.stopAnimation(false)
            self.animation.finishAnimation(at: .current)
            
        }
        //        self.animation = nil
        self.animation = UIViewPropertyAnimator(
            duration: 0.6,
            curve: .easeInOut,
            animations: {
                var translation: CGAffineTransform!
                if self.isRightSwipe {
                    translation = CGAffineTransform(translationX: -self.view.bounds.maxX, y: 0)
                }
                else {
                    translation = CGAffineTransform(translationX: self.view.bounds.maxX, y: 0)
                }
                
                self.leftImage.transform = translation
                self.rightImage.transform = translation
                self.centerImage.transform = translation
        })
        self.animation.pauseAnimation()
    }
    
    func setImage() {
        let leftPhotoIndex: Int = selectedPhoto - 1
        let centerPhotoIndex: Int = selectedPhoto
        let rightPhotoIndex: Int = selectedPhoto + 1
        
        view.subviews.forEach({ $0.removeFromSuperview() })
        leftImage = UIImageView()
        rightImage = UIImageView()
        centerImage = UIImageView()
        
        view.addSubview(leftImage)
        view.addSubview(centerImage)
        view.addSubview(rightImage)
        
        if leftPhotoIndex < 0 {
            leftImage.image = nil
        } else {
            leftImage.image = friend.photos[leftPhotoIndex]
        }
        
        if rightPhotoIndex >= friend.photos.count {
            rightImage.image = nil
        }
        else {
            rightImage.image = friend.photos[rightPhotoIndex]
        }
        
        centerImage.image = friend.photos[centerPhotoIndex]
        leftImage.translatesAutoresizingMaskIntoConstraints = false
        centerImage.translatesAutoresizingMaskIntoConstraints = false
        rightImage.translatesAutoresizingMaskIntoConstraints = false
        
        leftImage.contentMode = .scaleAspectFit
        centerImage.contentMode = .scaleAspectFit
        rightImage.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            leftImage.trailingAnchor.constraint(equalTo: view.leadingAnchor),
            leftImage.heightAnchor.constraint(equalToConstant: view.frame.height),
            leftImage.widthAnchor.constraint(equalToConstant: view.frame.width),
            
            centerImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            centerImage.heightAnchor.constraint(equalToConstant: view.frame.height),
            centerImage.widthAnchor.constraint(equalToConstant: view.frame.width),
            
            rightImage.leadingAnchor.constraint(equalTo: view.trailingAnchor),
            rightImage.heightAnchor.constraint(equalToConstant: view.frame.height),
            rightImage.widthAnchor.constraint(equalToConstant: view.frame.width),
        ])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        leftImage.removeFromSuperview()
    }
}
