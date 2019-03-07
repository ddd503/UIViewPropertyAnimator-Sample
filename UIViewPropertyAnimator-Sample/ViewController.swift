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

    }

    func 単純な横移動() {
        let endPointX = animationView.center.x + 50
        let animator = UIViewPropertyAnimator(duration: 1.0, curve: .easeIn) {
            self.animationView.center.x = endPointX
        }
        animator.startAnimation()
    }
}
