//
//  AnimationViewController.swift
//  UIViewPropertyAnimator-Sample
//
//  Created by kawaharadai on 2019/03/07.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

final class AnimationViewController: UIViewController {

    @IBOutlet weak var animationView: UIView!
    var animator: UIViewPropertyAnimator?
    var basePostion: CGPoint = .zero
    var currentAnimationType = AnimationType.move
    lazy var endPointY = {
        return self.animationView.center.y + 200
    }

    class func make(type: AnimationType) -> AnimationViewController {
        guard let animationVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "AnimationViewController") as? AnimationViewController else {
            fatalError()
        }
        animationVC.currentAnimationType = type
        return animationVC
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    @IBAction func action(_ sender: UIButton) {

    }

    @IBAction func slide(_ sender: UISlider) {
        sliderで進行度をコントロールできる(float: sender.value)
    }

    private func setup() {
        basePostion = animationView.center
        setupAnimator()
    }

    private func setupAnimator() {
        animator = UIViewPropertyAnimator(duration: 1.0, curve: .easeIn) {
            self.animationView.center.y = self.endPointY()
        }
    }

    private func setupAndStartAnimator() {
        let entPointY = animationView.center.y + 200
        animator = UIViewPropertyAnimator(duration: 1.0, curve: .easeIn) {
            self.animationView.center.y = entPointY
        }
        animator?.startAnimation()
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

    func バネのようなスプリント属性を持たせる移動() {
        let entPointY = animationView.center.y + 300
        let animator = UIViewPropertyAnimator(duration: 2.0,
                                              dampingRatio: 0.2,
                                              animations: {
                                                self.animationView.center.y = entPointY
        })
        animator.startAnimation()
    }

    func 進行中のanimationを逆再生したい時() {
        animator?.isReversed = animator?.isReversed ?? true ? false : true
    }

    func sliderで進行度をコントロールできる(float: Float) {
        // 事前にsetupAnimatorを読んでおく
        self.animator?.fractionComplete = CGFloat(float)
    }

    func アニメーションを追加する() {
        let entPointY = animationView.center.y + 200
        let animator = UIViewPropertyAnimator(duration: 2.0, curve: .easeIn) {
            self.animationView.center.y = entPointY
        }
        // アニメーションの追加（開始は一緒）
        animator.addAnimations {
            self.animationView.alpha = 0.0
        }
        animator.startAnimation()
    }

    func 遅延実行するアニメーションを追加する() {
        let entPointY = animationView.center.y + 200
        let animator = UIViewPropertyAnimator(duration: 2.0, curve: .easeIn) {
            self.animationView.center.y = entPointY
        }
        // アニメーションを追加（90%の時点で発火する遅延実行）
        animator.addAnimations({
            self.animationView.alpha = 0.0
        }, delayFactor: 0.9)
        animator.startAnimation()
    }

    func アニメーション完了後処理を追加する() {
        let entPointY = animationView.center.y + 200
        let animator = UIViewPropertyAnimator(duration: 2.0, curve: .easeIn) {
            self.animationView.center.y = entPointY
        }
        // 完了後の処理を追加
        animator.addCompletion { (_) in
            self.animationView.center.y = self.animationView.center.y - 200
        }
        animator.startAnimation()
    }
}
