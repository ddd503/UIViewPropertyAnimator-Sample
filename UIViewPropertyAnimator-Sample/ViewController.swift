//
//  ViewController.swift
//  UIViewPropertyAnimator-Sample
//
//  Created by kawaharadai on 2019/03/07.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var animationView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func action(_ sender: UIButton) {
        let entPointY = animationView.center.y + 200
        let animator = UIViewPropertyAnimator(duration: 2.0,
                                              controlPoint1: CGPoint(x: 0.1, y: 1.0),
                                              controlPoint2: CGPoint(x: 0.2, y: 0.1),
                                              animations: {
                                               self.animationView.center.y = entPointY
        })
        animator.startAnimation()
    }

    func 単純な横移動() {
        let endPointX = animationView.center.x + 50
        let animator = UIViewPropertyAnimator(duration: 1.0, curve: .easeIn) {
            self.animationView.center.x = endPointX
        }
        animator.startAnimation()
    }

    func ベジェ曲線で緩急をつける横移動() {
        let entPointY = animationView.center.y + 200
        let animator = UIViewPropertyAnimator(duration: 2.0,
                                              controlPoint1: CGPoint(x: 0.1, y: 1.0),
                                              controlPoint2: CGPoint(x: 0.2, y: 0.1),
                                              animations: {
                                                self.animationView.center.y = entPointY
        })
        animator.startAnimation()
    }

}
