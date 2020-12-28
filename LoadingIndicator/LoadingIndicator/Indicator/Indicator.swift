//
//  Indicator.swift
//  LoadingIndicator
//
//  Created by Yoyo on 12/28/20.
//

import UIKit

class IndicatorIcon: UIView {
    
    var lineWidth: CGFloat = 2 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.saveGState()
        
        let r = (min(rect.width, rect.height) - lineWidth) / 2.0
        
        let bezierPathTopLeft = UIBezierPath(arcCenter: rect.center, radius: r, startAngle: 0, endAngle: .pi/2, clockwise: true)
        ctx?.addPath(bezierPathTopLeft.cgPath)
        
        let bezierPathBottomRight = UIBezierPath(arcCenter: rect.center, radius: r, startAngle: .pi, endAngle: 3 * .pi / 2, clockwise: true)
        ctx?.addPath(bezierPathBottomRight.cgPath)
        
        ctx?.setStrokeColor(self.tintColor.cgColor)
        ctx?.setLineWidth(lineWidth)
        ctx?.strokePath()
        
        ctx?.restoreGState()
    }
}

class Indicator: UIView {
    
    struct Constant {
        static let duration: Double = 0.5
    }
    
    private var icon: IndicatorIcon!
    
    override init(frame: CGRect) {
        let r = min(frame.width, frame.height) / 2.0
        let center = frame.center
        
        super.init(frame: CGRect(x: center.x - r, y: center.y - r, width: 2 * r, height: 2 * r))
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let r = min(frame.width, frame.height) / 2.0
        icon = IndicatorIcon(frame: CGRect(x: 0, y: 0, width: r, height: r))
        icon.center = bounds.center
        icon.tintColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        self.addSubview(icon)
        
        self.backgroundColor = UIColor.white
        self.layer.masksToBounds = false
        self.layer.cornerRadius = r
        self.layer.shadowOpacity = 1
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        self.layer.shadowRadius = 6
    }
    
    func pull(to percent: CGFloat) {
        let animation = UIViewPropertyAnimator(duration: Constant.duration, curve: .linear) {
            self.icon.transform = .init(rotationAngle: percent * .pi * 2)
        }
        animation.startAnimation()
    }
    
    func startAnim() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = Double.pi * 2
        animation.duration = Constant.duration
        animation.repeatCount = Float.infinity
        icon.layer.add(animation, forKey: "rotationAnimation")
    }
    
    func endAnim() {
        let scaleAnim = CABasicAnimation(keyPath: "transform.scale")
        scaleAnim.fromValue = 1
        scaleAnim.toValue = 0
        scaleAnim.duration = Constant.duration
        
        let fadeAnim = CABasicAnimation(keyPath: "opacity")
        fadeAnim.fromValue = 0.25
        fadeAnim.toValue = 1
        fadeAnim.duration = Constant.duration
        
        let groupAnim = CAAnimationGroup()
        groupAnim.delegate = self
        groupAnim.animations = [scaleAnim, scaleAnim]
        groupAnim.duration = Constant.duration
        groupAnim.beginTime = 0
        self.layer.add(groupAnim, forKey: "endAnim")
    }
}

extension Indicator: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        icon.layer.removeAllAnimations()
    }
}

