//
//  SquareView.swift
//  Squares
//
//  Created by Yaroslav Abaturov on 17/08/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import UIKit

class SquareView: UIView {

    // MARK: - Model section
    var squareModel: SquareViewModelType?
    
    //MARK: - elements section
    var contentArea = UIView()
    var titleTextField = UITextField()
    var discriptionTextField = UITextView()
    var deadLine = UIDatePicker()
    var openCloseButton = UIButton()
    var settingsButton = UIButton()
    
    //    var lockView = UIView()
    
    //MARK: - constants
//    var mainFrameSize = CGSize(width: 160, height: 160)
    var contentViewRect = CGRect(origin: CGPoint(x: 20, y: 0), size: CGSize(width: 160, height: 160))
    let titleTFRect = CGRect(origin: CGPoint(x: 5, y: 5), size: CGSize(width: 150, height: 25))
    let discriptionTVRect = CGRect(origin: CGPoint(x: 5, y: 35), size: CGSize(width: 150, height: 85))
    let openCloseButtonRect = CGRect(origin: CGPoint(x: 125, y: 125), size: CGSize(width: 30, height: 30))
    let settingsButtonRect = CGRect(origin: CGPoint(x: 5, y: 125), size: CGSize(width: 30, height: 30))
    
    // - MARK: Life Cycle
    convenience init(withModel model: SquareViewModelType) {
        self.init(frame: CGRect(x: 0, y: 0, width: 160, height: 160))
        self.squareModel = model
        self.tag = 2
        setupDefaultViewProperties()
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
    
    private func setupDefaultViewProperties() {
        // self view block
//        self.alpha = 0.5
//        let selfBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        self.backgroundColor = selfBackgroundColor
        
        //Common properties
        let borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        // ContentArea
        contentArea = UIView(frame: contentViewRect)
        let contentColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        contentArea.backgroundColor = contentColor
        contentArea.layer.cornerRadius = 10
        contentArea.layer.borderColor = borderColor.cgColor
        contentArea.layer.borderWidth = 1
        contentArea.layer.masksToBounds = true
        
        self.addSubview(contentArea)
        
        //Elements
        //Adding tite text field
        titleTextField = UITextField(frame: titleTFRect)
        titleTextField.borderStyle = .roundedRect
        titleTextField.clearButtonMode = .whileEditing
        titleTextField.font = UIFont(name: "Apple SD Gothic Neo", size: 12)
        titleTextField.placeholder = "<Enter a title>"
        contentArea.addSubview(titleTextField)
        
        //adding discibing textView
        discriptionTextField = UITextView(frame: discriptionTVRect)
        discriptionTextField.font = UIFont(name: "Apple SD Gothic Neo", size: 10)
        contentArea.addSubview(discriptionTextField)
        
        //Adding buttons
        //oen|close button
        openCloseButton = UIButton(frame: openCloseButtonRect)
        openCloseButton.backgroundColor = UIColor.red
        
        openCloseButton.layer.cornerRadius = openCloseButton.frame.height / 2
        openCloseButton.layer.masksToBounds = true
        openCloseButton.layer.borderColor = borderColor.cgColor
        openCloseButton.layer.borderWidth = 2
        contentArea.addSubview(openCloseButton)
        
        //Settings button
        settingsButton = UIButton(frame: settingsButtonRect)
        
        settingsButton.layer.cornerRadius = openCloseButton.frame.height / 5
        settingsButton.layer.masksToBounds = true
        settingsButton.layer.borderColor = borderColor.cgColor
        settingsButton.layer.borderWidth = 2
        
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
        
        let defaultLineWidth: CGFloat = 3
        let defaultStrokeEnd: CGFloat = 1
        let defaultOpacity: Float = 1
        
        let lineShapeLayer_1 = CAShapeLayer()
        lineShapeLayer_1.lineWidth = defaultLineWidth
        lineShapeLayer_1.lineCap = convertToCAShapeLayerLineCap("round")
        lineShapeLayer_1.fillColor = nil
        lineShapeLayer_1.strokeEnd = defaultStrokeEnd
        lineShapeLayer_1.opacity = defaultOpacity
        lineShapeLayer_1.strokeColor = baseLineColor.cgColor
        lineShapeLayer_1.path = linePath_1.cgPath
        
        let lineShapeLayer_2 = CAShapeLayer()
        lineShapeLayer_2.lineWidth = defaultLineWidth
        lineShapeLayer_2.lineCap = convertToCAShapeLayerLineCap("round")
        lineShapeLayer_2.fillColor = nil
        lineShapeLayer_2.strokeEnd = defaultStrokeEnd
        lineShapeLayer_2.opacity = defaultOpacity
        lineShapeLayer_2.strokeColor = baseLineColor.cgColor
        lineShapeLayer_2.path = linePath_2.cgPath
        
        let lineShapeLayer_3 = CAShapeLayer()
        lineShapeLayer_3.lineWidth = defaultLineWidth
        lineShapeLayer_3.lineCap = convertToCAShapeLayerLineCap("round")
        lineShapeLayer_3.fillColor = nil
        lineShapeLayer_3.strokeEnd = defaultStrokeEnd
        lineShapeLayer_3.opacity = defaultOpacity
        lineShapeLayer_3.strokeColor = baseLineColor.cgColor
        lineShapeLayer_3.path = linePath_3.cgPath

        settingsButton.layer.addSublayer(lineShapeLayer_1)
        settingsButton.layer.addSublayer(lineShapeLayer_2)
        settingsButton.layer.addSublayer(lineShapeLayer_3)
        
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped(sender:)), for: .touchUpInside)
        
        contentArea.addSubview(settingsButton)
    }
    
    private func setValues() {
        guard let model = squareModel else { return }
            titleTextField.text = model.squareTitle
            discriptionTextField.text = model.squareDiscription
        guard let _deadLine_ = model.deadLine else { return }
        deadLine.date = _deadLine_
    }
    
    // - MARK: Animations
    
    private func animateAppearing() {
//
        UIView.transition(with: self, duration: 0.5, options: [.curveLinear, .allowUserInteraction], animations: { [unowned self] in
            self.alpha = 1

            let linearTiming = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
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
                let linearTiming = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
                //            let beginTime: TimeInterval = 0
                let borderWidthAmination = CAKeyframeAnimation(keyPath: "borderWidth")
                borderWidthAmination.duration = 1
                borderWidthAmination.values = [2.000,15.000, 2.000] as [Float]
                borderWidthAmination.keyTimes = [0.000, 0.500, 1.000] as [NSNumber]
                borderWidthAmination.timingFunctions = [linearTiming, linearTiming]
                borderWidthAmination.beginTime = 0
                borderWidthAmination.isRemovedOnCompletion = false
                self.openCloseButton.layer.add(borderWidthAmination, forKey:"BorderWidth Animation")

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
//
    func animateTerminating() {
        UIView.transition(with: self, duration: 0.5, options: [.curveLinear, .allowUserInteraction], animations: {
            self.alpha = 0

            let linearTiming = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
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
    
//    func animateLiftUp() {
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
//    }
    
//    func animateLiftDown() {
//        UIView.transition(with: self, duration: 0.5, options: [.curveLinear, .allowUserInteraction], animations: { [unowned self] in
//            let linearTiming = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
//            //            let beginTime: TimeInterval = 0
//            let scaleXAmination = CAKeyframeAnimation(keyPath: "transform.scale.x")
//            scaleXAmination.duration = 0.5
//            scaleXAmination.values = [1.100, 0.000] as [Float]
//            scaleXAmination.keyTimes = [0.000, 1.000] as [NSNumber]
//            scaleXAmination.timingFunctions = [linearTiming, linearTiming]
//            scaleXAmination.beginTime = 0
//            //        _1200pxFarbkreisItten1961ScaleXAnimation.fillMode = fillMode
//            scaleXAmination.isRemovedOnCompletion = false
//            self.layer.add(scaleXAmination, forKey:"Untitled Animation_ScaleX")
//
//            let scaleYAmination = CAKeyframeAnimation(keyPath: "transform.scale.y")
//            scaleYAmination.duration = 0.5
//            scaleYAmination.values = [0.000, 1.100] as [Float]
//            scaleYAmination.keyTimes = [0.000, 1.000] as [NSNumber]
//            scaleYAmination.timingFunctions = [linearTiming, linearTiming]
//            scaleYAmination.beginTime = 0
//            //        _1200pxFarbkreisItten1961ScaleYAnimation.fillMode = fillMode
//            scaleYAmination.isRemovedOnCompletion = false
//            self.layer.add(scaleYAmination, forKey:"Untitled Animation_ScaleY")
//        })
//    }
    
//    private func animateClosingItem() {
//        self.titleTextField.isEnabled = false
//        self.discriptionTextField.isEditable = false
//        self.actionButton.backgroundColor = UIColor.green
//        self.actionButton.setTitle("Open", for: .normal)
//
//        UIView.transition(with: self, duration: 0.5, options: [.curveEaseInOut], animations: { [unowned self] in
//            self.titleTextField.frame.size.width = 115
//            self.discriptionTextField.alpha = 0
//            self.settingsButton.alpha = 0
//            self.actionButton.frame.size = CGSize(width: 30, height: 25)
//            self.actionButton.layer.cornerRadius = self.actionButton.frame.size.height / 2
//            self.actionButton.center.y = self.titleTextField.center.y
//            self.frame.size.height = 35
//        })
//    }
    
//    private func animateOpeningItem() {
//        self.titleTextField.isEnabled = true
//        self.discriptionTextField.isEditable = true
//        self.actionButton.backgroundColor = UIColor.red
//        self.actionButton.setTitle("Save", for: .normal)
//
//        UIView.transition(with: self, duration: 0.5, options: [.curveEaseInOut], animations: { [unowned self] in
//            self.titleTextField.frame.size.width = self.titleTFRect.size.width
//            self.discriptionTextField.alpha = 1
//            self.settingsButton.alpha = 1
//            self.actionButton.frame.size = CGSize(width: 30, height: 30)
//            self.actionButton.layer.cornerRadius = self.actionButton.frame.size.width / 2
//            self.actionButton.frame.origin.y = 125
//            self.frame.size.height = self.contentViewRect.size.height
//        })
//    }
    
    // - MARK: BUtton actions
    
//    @objc func actionButtonTapped(sender: UIButton) {
//        guard let model = squareModel else { return }
//        model.saveItem(xPosition: Float(self.convert(self.frame.origin, to: superview).x) / 2, yPosition: Float(self.convert(self.frame.origin, to: superview).y) / 2, deadLine: nil, isFinished: false)
//        switchEditingMode()
//    }
    
//    func switchEditingMode() {
//        if self.actionButton.currentTitle == "Save" {
//            animateClosingItem()
//        } else {
//            animateOpeningItem()
//        }
//    }
    
    @objc func settingsButtonTapped(sender: UIButton) {
//        titleTextField.isHidden = true
//        discriptionTextField.isHidden = true
//        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToCAShapeLayerLineCap(_ input: String) -> CAShapeLayerLineCap {
	return CAShapeLayerLineCap(rawValue: input)
}
