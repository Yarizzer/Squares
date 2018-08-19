//
//  SquareView.swift
//  Squares
//
//  Created by Yaroslav Abaturov on 17/08/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import UIKit

class SquareView: UIView {

    var squareModel: SquareViewModelType?
    
    var titleTextField = UITextField()
    var discriptionTextField = UITextView()
    var actionButton = UIButton()
    var settingsButton = UIButton()
    //    var lockView = UIView()
    
    // - MARK: Life Cycle
    
    convenience init(withModel model: SquareViewModelType) {
        self.init(frame: CGRect(x: 0, y: 0, width: 160 , height: 160))
        self.squareModel = model
        self.tag = 2
        setupDefaultViewProreties()
        setValues()
        animateAppearing()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //        animateAppearing()
    }
    
    // - MARK: Setting properties and values
    
    private func setupDefaultViewProreties() {
        // Background
        self.alpha = 1
        let backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.backgroundColor = backgroundColor
        
        //Layer
        self.layer.cornerRadius = 10
        //        self.alpha  = 0
        let borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 1
        self.layer.masksToBounds = true
        
        //Elements
        //Adding tite text field
        titleTextField = UITextField(frame: CGRect(origin: CGPoint(x: 5, y: 5), size: CGSize(width: 150, height: 25)))
        titleTextField.borderStyle = .roundedRect
        titleTextField.clearButtonMode = .whileEditing
        titleTextField.font = UIFont(name: "Apple SD Gothic Neo", size: 12)
        self.addSubview(titleTextField)
        
        //adding discibing textView
        discriptionTextField = UITextView(frame: CGRect(origin: CGPoint(x: 5, y: 35), size: CGSize(width: 150, height: 85)))
        discriptionTextField.font = UIFont(name: "Apple SD Gothic Neo", size: 10)
        self.addSubview(discriptionTextField)
        
        //Adding buttons
        //Common buttot properties
        let buttonBorderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        //Adding 'Done' button
        
        actionButton = UIButton(frame: CGRect(origin: CGPoint(x: 125, y: 125), size: CGSize(width: 30, height: 30)))
        //        actionButton.isHidden = true
        actionButton.backgroundColor = UIColor.red
        actionButton.layer.cornerRadius = actionButton.frame.size.height / 2
        actionButton.layer.masksToBounds = true
        actionButton.layer.borderColor = buttonBorderColor.cgColor
        actionButton.layer.borderWidth = 2
        actionButton.setTitle("Save", for: .normal)
        actionButton.titleLabel?.font = UIFont(name: "Apple SD Gothic Neo", size: 10)
        actionButton.addTarget(self, action: #selector(actionButtonTapped(sender:)), for: .touchUpInside)
        self.addSubview(actionButton)
        
        settingsButton = UIButton(frame: CGRect(origin: CGPoint(x: 5, y: 125), size: CGSize(width: 30, height: 30)))
        
        let linePath_1 = UIBezierPath()
        linePath_1.move(to: CGPoint(x: settingsButton.frame.width / 6, y: settingsButton.frame.height / 5))
        linePath_1.addLine(to: CGPoint(x: settingsButton.frame.width - (settingsButton.frame.width / 6), y: settingsButton.frame.height / 5))
        
        let linePath_2 = UIBezierPath()
        linePath_2.move(to: CGPoint(x: settingsButton.frame.width / 6, y: settingsButton.frame.height / 2))
        linePath_2.addLine(to: CGPoint(x: settingsButton.frame.width - (settingsButton.frame.width / 6), y: settingsButton.frame.height / 2))
        
        let linePath_3 = UIBezierPath()
        linePath_3.move(to: CGPoint(x: settingsButton.frame.width / 6, y: settingsButton.frame.height - (settingsButton.frame.height / 5)))
        linePath_3.addLine(to: CGPoint(x: settingsButton.frame.width - (settingsButton.frame.width / 6), y: settingsButton.frame.height - (settingsButton.frame.height / 5)))
        
        let baseLineColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        
        let lineShapeLayer_1 = CAShapeLayer()
        lineShapeLayer_1.lineWidth = 3
        lineShapeLayer_1.lineCap = "round"
        lineShapeLayer_1.fillColor = nil
        lineShapeLayer_1.strokeEnd = 1
        lineShapeLayer_1.opacity = 1
        lineShapeLayer_1.strokeColor = baseLineColor.cgColor
        lineShapeLayer_1.path = linePath_1.cgPath
        
        let lineShapeLayer_2 = CAShapeLayer()
        lineShapeLayer_2.lineWidth = 3
        lineShapeLayer_2.lineCap = "round"
        lineShapeLayer_2.fillColor = nil
        lineShapeLayer_2.strokeEnd = 1
        lineShapeLayer_2.opacity = 1
        lineShapeLayer_2.strokeColor = baseLineColor.cgColor
        lineShapeLayer_2.path = linePath_2.cgPath
        
        let lineShapeLayer_3 = CAShapeLayer()
        lineShapeLayer_3.lineWidth = 3
        lineShapeLayer_3.lineCap = "round"
        lineShapeLayer_3.fillColor = nil
        lineShapeLayer_3.strokeEnd = 1
        lineShapeLayer_3.opacity = 1
        lineShapeLayer_3.strokeColor = baseLineColor.cgColor
        lineShapeLayer_3.path = linePath_3.cgPath
        
        settingsButton.layer.addSublayer(lineShapeLayer_1)
        settingsButton.layer.addSublayer(lineShapeLayer_2)
        settingsButton.layer.addSublayer(lineShapeLayer_3)
        
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped(sender:)), for: .touchUpInside)
        self.addSubview(settingsButton)
    }
    
    private func setValues() {
        guard let model = squareModel else { return }
            titleTextField.text = model.squareTitle
            discriptionTextField.text = model.squareDiscription
    }
    
    // - MARK: Animations
    
    private func animateAppearing() {
        
        UIView.transition(with: self, duration: 0.5, options: [.curveLinear, .allowUserInteraction], animations: { [unowned self] in
            self.alpha = 1
            
            let linearTiming = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            //            let beginTime: TimeInterval = 0
            let scaleXAmination = CAKeyframeAnimation(keyPath: "transform.scale.x")
            scaleXAmination.duration = 1
            scaleXAmination.values = [0.000, 1.100, 1.000] as [Float]
            scaleXAmination.keyTimes = [0.000, 0.200, 1.000] as [NSNumber]
            scaleXAmination.timingFunctions = [linearTiming, linearTiming]
            scaleXAmination.beginTime = 0
            //        _1200pxFarbkreisItten1961ScaleXAnimation.fillMode = fillMode
            scaleXAmination.isRemovedOnCompletion = true
            self.layer.add(scaleXAmination, forKey:"Untitled Animation_ScaleX")
            
            let scaleYAmination = CAKeyframeAnimation(keyPath: "transform.scale.y")
            scaleYAmination.duration = 1
            scaleYAmination.values = [0.000, 1.100, 1.000] as [Float]
            scaleYAmination.keyTimes = [0.000, 0.200, 1.000] as [NSNumber]
            scaleYAmination.timingFunctions = [linearTiming, linearTiming]
            scaleYAmination.beginTime = 0
            //        _1200pxFarbkreisItten1961ScaleYAnimation.fillMode = fillMode
            scaleYAmination.isRemovedOnCompletion = true
            self.layer.add(scaleYAmination, forKey:"Untitled Animation_ScaleY")
            }, completion: { _ in
                let linearTiming = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
                //            let beginTime: TimeInterval = 0
                let borderWidthAmination = CAKeyframeAnimation(keyPath: "borderWidth")
                borderWidthAmination.duration = 1
                borderWidthAmination.values = [2.000,15.000, 2.000] as [Float]
                borderWidthAmination.keyTimes = [0.000, 0.500, 1.000] as [NSNumber]
                borderWidthAmination.timingFunctions = [linearTiming, linearTiming]
                borderWidthAmination.beginTime = 0
                borderWidthAmination.isRemovedOnCompletion = false
                self.actionButton.layer.add(borderWidthAmination, forKey:"BorderWidth Animation")
                
                //                let spring = CASpringAnimation(keyPath: "strokeEnd")
                //                spring.damping = 5
                //                spring.fromValue = 0
                //                spring.toValue = 1
                //                spring.duration = spring.settlingDuration
                
                let settingsButtonLayersAnimation = CAKeyframeAnimation(keyPath: "strokeEnd")
                settingsButtonLayersAnimation.duration = 1
                settingsButtonLayersAnimation.values = [0.000, 1.000] as [Float]
                settingsButtonLayersAnimation.keyTimes = [0.000, 1.000] as [NSNumber]
                settingsButtonLayersAnimation.timingFunctions = [linearTiming, linearTiming]
                settingsButtonLayersAnimation.beginTime = 0
                settingsButtonLayersAnimation.isRemovedOnCompletion = false
                for i in self.settingsButton.layer.sublayers! {
                    //                    i.add(spring, forKey: "spring animation")
                    i.add(settingsButtonLayersAnimation, forKey: "settingsBUtton animation")
                }
                
        })
        
    }
    
    func animateTerminating() {
        UIView.transition(with: self, duration: 0.5, options: [.curveLinear, .allowUserInteraction], animations: {
            self.alpha = 0
            
            let linearTiming = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            //            let beginTime: TimeInterval = 0
            let scaleXAmination = CAKeyframeAnimation(keyPath: "transform.scale.x")
            scaleXAmination.duration = 1
            scaleXAmination.values = [1.000, 1.100, 0.000] as [Float]
            scaleXAmination.keyTimes = [0.000, 0.200, 1.000] as [NSNumber]
            scaleXAmination.timingFunctions = [linearTiming, linearTiming]
            scaleXAmination.beginTime = 0
            //        _1200pxFarbkreisItten1961ScaleXAnimation.fillMode = fillMode
            scaleXAmination.isRemovedOnCompletion = true
            self.layer.add(scaleXAmination, forKey:"Untitled Animation_ScaleX")
            
            let scaleYAmination = CAKeyframeAnimation(keyPath: "transform.scale.y")
            scaleYAmination.duration = 1
            scaleYAmination.values = [1.000, 1.100, 0.000] as [Float]
            scaleYAmination.keyTimes = [0.000, 0.200, 1.000] as [NSNumber]
            scaleYAmination.timingFunctions = [linearTiming, linearTiming]
            scaleYAmination.beginTime = 0
            //        _1200pxFarbkreisItten1961ScaleYAnimation.fillMode = fillMode
            scaleYAmination.isRemovedOnCompletion = true
            self.layer.add(scaleYAmination, forKey:"Untitled Animation_ScaleY")
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
    
    func animateLiftUp() {
//        UIView.transition(with: self, duration: 0.5, options: [.allowUserInteraction, .curveEaseOut], animations: { [unowned self] in
            //            self.frame.size.width = self.frame.size.width + (self.frame.size.width * 0.1)
            //            self.frame.size.height = self.frame.size.height + (self.frame.size.width * 0.1)
            
//        })
        //        UIView.transition(with: self, duration: 0.5, options: [.curveLinear, .allowUserInteraction], animations: { [unowned self] in
        //            let linearTiming = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        //            //            let beginTime: TimeInterval = 0
        //            let scaleXAmination = CAKeyframeAnimation(keyPath: "transform.scale.x")
        //            scaleXAmination.duration = 0.5
        //            scaleXAmination.values = [1.000, 1.100] as [Float]
        //            scaleXAmination.keyTimes = [0.000, 1.000] as [NSNumber]
        //            scaleXAmination.timingFunctions = [linearTiming, linearTiming]
        //            scaleXAmination.beginTime = 0
        //            //        _1200pxFarbkreisItten1961ScaleXAnimation.fillMode = fillMode
        //            scaleXAmination.isRemovedOnCompletion = false
        //            self.layer.add(scaleXAmination, forKey:"Untitled Animation_ScaleX")
        //
        //            let scaleYAmination = CAKeyframeAnimation(keyPath: "transform.scale.y")
        //            scaleYAmination.duration = 0.5
        //            scaleYAmination.values = [1.000, 1.100] as [Float]
        //            scaleYAmination.keyTimes = [0.000, 1.000] as [NSNumber]
        //            scaleYAmination.timingFunctions = [linearTiming, linearTiming]
        //            scaleYAmination.beginTime = 0
        //            //        _1200pxFarbkreisItten1961ScaleYAnimation.fillMode = fillMode
        //            scaleYAmination.isRemovedOnCompletion = false
        //            self.layer.add(scaleYAmination, forKey:"Untitled Animation_ScaleY")
        //        })
    }
    
    func animateLiftDown() {
        UIView.transition(with: self, duration: 0.5, options: [.curveLinear, .allowUserInteraction], animations: { [unowned self] in
            let linearTiming = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            //            let beginTime: TimeInterval = 0
            let scaleXAmination = CAKeyframeAnimation(keyPath: "transform.scale.x")
            scaleXAmination.duration = 0.5
            scaleXAmination.values = [1.100, 0.000] as [Float]
            scaleXAmination.keyTimes = [0.000, 1.000] as [NSNumber]
            scaleXAmination.timingFunctions = [linearTiming, linearTiming]
            scaleXAmination.beginTime = 0
            //        _1200pxFarbkreisItten1961ScaleXAnimation.fillMode = fillMode
            scaleXAmination.isRemovedOnCompletion = false
            self.layer.add(scaleXAmination, forKey:"Untitled Animation_ScaleX")
            
            let scaleYAmination = CAKeyframeAnimation(keyPath: "transform.scale.y")
            scaleYAmination.duration = 0.5
            scaleYAmination.values = [0.000, 1.100] as [Float]
            scaleYAmination.keyTimes = [0.000, 1.000] as [NSNumber]
            scaleYAmination.timingFunctions = [linearTiming, linearTiming]
            scaleYAmination.beginTime = 0
            //        _1200pxFarbkreisItten1961ScaleYAnimation.fillMode = fillMode
            scaleYAmination.isRemovedOnCompletion = false
            self.layer.add(scaleYAmination, forKey:"Untitled Animation_ScaleY")
        })
    }
    
    private func animateClosingItem() {
        self.titleTextField.isEnabled = false
        self.discriptionTextField.isEditable = false
        self.actionButton.backgroundColor = UIColor.green
        self.actionButton.setTitle("Open", for: .normal)
        
        UIView.transition(with: self, duration: 0.5, options: [.curveEaseInOut], animations: { [unowned self] in
            self.titleTextField.frame.size.width = 115
            self.discriptionTextField.alpha = 0
            self.settingsButton.alpha = 0
            self.actionButton.frame.size = CGSize(width: 30, height: 25)
            self.actionButton.layer.cornerRadius = self.actionButton.frame.size.height / 2
            self.actionButton.center.y = self.titleTextField.center.y
            self.frame.size.height = 35
        })
    }
    
    private func animateOpeningItem() {
        self.titleTextField.isEnabled = true
        self.discriptionTextField.isEditable = true
        self.actionButton.backgroundColor = UIColor.red
        self.actionButton.setTitle("Save", for: .normal)
        
        UIView.transition(with: self, duration: 0.5, options: [.curveEaseInOut], animations: { [unowned self] in
            self.titleTextField.frame.size.width = 150
            self.discriptionTextField.alpha = 1
            self.settingsButton.alpha = 1
            self.actionButton.frame.size = CGSize(width: 30, height: 30)
            self.actionButton.layer.cornerRadius = self.actionButton.frame.size.width / 2
            self.actionButton.frame.origin.y = 125
            self.frame.size.height = 160
        })
    }
    
    // - MARK: BUtton actions
    
    @objc func actionButtonTapped(sender: UIButton) {
//        guard let model = itemModel else { return }
//        model.saveItem()
        switchEditingMode()
    }
    
    func switchEditingMode() {
        if self.actionButton.currentTitle == "Save" {
            animateClosingItem()
        } else {
            animateOpeningItem()
        }
    }
    
    @objc func settingsButtonTapped(sender: UIButton) {
        print("Settings button tapped")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
