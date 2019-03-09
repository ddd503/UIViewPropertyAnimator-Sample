//
//  AnimationViewController.swift
//  UIViewPropertyAnimator-Sample
//
//  Created by kawaharadai on 2019/03/07.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

final class AnimationViewController: UIViewController {

    @IBOutlet private weak var animationView: UIView!
    @IBOutlet private weak var button: UIButton!
    @IBOutlet private weak var slider: UISlider!

    var animator: UIViewPropertyAnimator?
    var basePostion: CGPoint = .zero
    var currentAnimationType = AnimationType.move
    lazy var endPointY = {
        return self.animationView.center.y + 200
    }
    let duration: TimeInterval = 2.0

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
        triggerAction()
        resetPosition()
    }

    @IBAction func slide(_ sender: UISlider) {
        sliderで進行度をコントロールできる(float: sender.value)
    }

    private func setup() {
        button.isHidden = currentAnimationType == .slider
        slider.isHidden = !(currentAnimationType == .slider)
        basePostion = animationView.center
        basePostion.y = basePostion.y + 64
        setupAnimator()
    }

    private func triggerAction() {
        switch currentAnimationType {
        case .move:
            単純な移動()
        case .bezierCurve:
            ベジェ曲線で緩急をつける横移動()
        case .spring:
            バネのようなスプリント属性を持たせる移動()
        case .reversed:
            進行中のanimationを逆再生したい時()
        case .add:
            アニメーションを追加する()
        case .addDelay:
            遅延実行するアニメーションを追加する()
        default: break
        }
    }

    private func setupAnimator() {
        animator = UIViewPropertyAnimator(duration: duration, curve: .easeIn) {
            self.animationView.center.y = self.endPointY()
        }
    }

    private func resetPosition() {
        DispatchQueue.main.asyncAfter(deadline: .now() + duration + 1.0) { [weak self] in
            guard let self = self else { return }
            self.animationView.center = self.basePostion
            self.animationView.backgroundColor = .blue
            self.animationView.alpha = 1.0
        }
    }

    func 単純な移動() {
        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeIn) {
            self.animationView.center.y = self.endPointY()
        }
        animator.startAnimation()
    }

    func ベジェ曲線で緩急をつける横移動() {
        let animator = UIViewPropertyAnimator(duration: duration,
                                              controlPoint1: CGPoint(x: 0.1, y: 1.0),
                                              controlPoint2: CGPoint(x: 0.2, y: 0.1),
                                              animations: {
                                                self.animationView.center.y = self.endPointY()
        })
        animator.startAnimation()
    }

    func バネのようなスプリント属性を持たせる移動() {
        let animator = UIViewPropertyAnimator(duration: duration,
                                              dampingRatio: 0.2,
                                              animations: {
                                                self.animationView.center.y = self.endPointY()
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
        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeIn) {
            self.animationView.center.y = self.endPointY()
        }
        // アニメーションの追加（開始は一緒）
        animator.addAnimations {
            self.animationView.alpha = 0.0
        }
        animator.startAnimation()
    }

    func 遅延実行するアニメーションを追加する() {
        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeIn) {
            self.animationView.center.y = self.endPointY()
        }
        // アニメーションを追加（90%の時点で発火する遅延実行）
        animator.addAnimations({
            self.animationView.alpha = 0.0
        }, delayFactor: 0.9)
        animator.startAnimation()
    }

    func アニメーション完了後処理を追加する() {
        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeIn) {
            self.animationView.center.y = self.endPointY()
        }
        // 完了後の処理を追加
        animator.addCompletion { (_) in
            self.animationView.backgroundColor = .red
        }
        animator.startAnimation()
    }
}
