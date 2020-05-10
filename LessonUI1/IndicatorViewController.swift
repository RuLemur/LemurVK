//
//  IndicatorViewController.swift
//  LessonUI1
//
//  Created by Александр Павлов on 27.04.2020.
//  Copyright © 2020 Александр Павлов. All rights reserved.
//

import UIKit

class IndicatorViewController: UIViewController {
    let loadingView = LoadingView.loadFromNib()
    
    @IBOutlet weak var dot1: UIView!
    @IBOutlet weak var dot2: UIView!
    @IBOutlet weak var dot3: UIView!
    @IBOutlet weak var cons: NSLayoutConstraint!
    @IBOutlet weak var qqq: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dot1.layer.cornerRadius = dot1.frame.size.height / 2
        dot2.layer.cornerRadius = dot2.frame.size.height / 2
        dot3.layer.cornerRadius = dot3.frame.size.height / 2
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1, delay: 0, options: .repeat, animations: {
            self.dot1.alpha = 0
        })
        UIView.animate(withDuration: 1, delay: 0.4, options: .repeat, animations: {
            self.dot2.alpha = 0
        })
        UIView.animate(withDuration: 1, delay: 0.8, options: [.repeat], animations: {
            self.dot3.alpha = 0
        })
    }
    @IBAction func dsgfdg(_ sender: Any) {
        view.layoutIfNeeded()
        
//        cons.isActive = false
        
        qqq.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        
        let yAnimator = UIViewPropertyAnimator(duration: 10, curve: .easeInOut) {
            
            self.view.layoutIfNeeded()
        }
        
        yAnimator.startAnimation()
    }
}
