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
    
    // - MARK: Life Cycle
    convenience init(withModel model: SquareViewModelType) {
        self.init()
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
    
    //MARK: - elements section
    private var contentArea = UIView()
    var titleTextField = UITextField()
    var discriptionTextField = UITextView()
    var deadline = UIDatePicker()
    private var openCloseButton = UIButton()
    private var doneMarkButton = UIButton()
    var deadlineSwitcher = UISwitch()
    
    //MARK: - Rects
    
    //Content area 
    private let openedContentArea = CGRect(origin: CGPoint.zero, size: CGSize(width: 300, height: 300))
    private let closedContentArea = CGRect(origin: CGPoint.zero, size: CGSize(width: 145, height: 35))
    //TitleTF
    private let openedTitleRect = CGRect(origin: CGPoint(x: 5, y: 5), size: CGSize(width: 260, height: 25))
    private let closedTitleRect = CGRect(origin: CGPoint(x: 5, y: 5), size: CGSize(width: 100, height: 25))
    //DiscriptionTV
    private let discriptionTVRect = CGRect(origin: CGPoint(x: 5, y: 35), size: CGSize(width: 290, height: 195))
    //Open-close button
    private let defaultOpenCloseButtonRect = CGRect(origin: CGPoint(x: 260, y: 260), size: CGSize(width: 35, height: 35))
    private let collapsedOpenCloseButtonRect = CGRect(origin: CGPoint(x: 110, y: 5), size: CGSize(width: 30, height: 25))
    //Done mark button
    private let hidenMarkBtnRect = CGRect(origin: CGPoint(x: -30, y: 5), size: CGSize(width: 25, height: 25))
    private let shawnMarkBtnInactive = CGRect(origin: CGPoint(x: 270, y: 5), size: CGSize(width: 25, height: 25))
    //Switch
    private let deadlineSwitcherRect = CGRect(origin: CGPoint(x: 305, y: 35), size: CGSize(width: 51, height: 30))
    private var defSwitcherViewHidenXPosition: CGFloat = 305
    //pickers
    private let datePickerRect = CGRect(origin: CGPoint(x: 305, y: 70), size: CGSize(width: 290, height: 160))
    private var defPickerViewsHidenXPosition: CGFloat = 305
    
    // - MARK: Setting properties and values
    private func setupDefaultViewProperties() {
        // self view block
//        self.alpha = 0.5
        let selfBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.backgroundColor = selfBackgroundColor
        self.frame = closedContentArea
        
        //Common properties
        let borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        // ContentArea
        contentArea = UIView(frame: closedContentArea)
        let contentColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        contentArea.backgroundColor = contentColor
        contentArea.layer.cornerRadius = 10
        contentArea.layer.borderColor = borderColor.cgColor
        contentArea.layer.borderWidth = 1
        contentArea.layer.masksToBounds = true
        self.addSubview(contentArea)
        
        //Elements
        //Adding tite text field
        titleTextField = UITextField(frame: closedTitleRect)
        titleTextField.isEnabled = false
        titleTextField.borderStyle = .roundedRect
        titleTextField.clearButtonMode = .whileEditing
        titleTextField.font = UIFont(name: "Apple SD Gothic Neo", size: 14)
        titleTextField.placeholder = "<Enter a title>"
        titleTextField.returnKeyType = .done
        titleTextField.keyboardAppearance = .dark
        contentArea.addSubview(titleTextField)
        
        //adding discibing textView
        discriptionTextField = UITextView(frame: discriptionTVRect)
        discriptionTextField.isEditable = false
        discriptionTextField.alpha = 0
        discriptionTextField.font = UIFont(name: "Apple SD Gothic Neo", size: 12)
        discriptionTextField.keyboardAppearance = .dark
        discriptionTextField.returnKeyType = .done
        contentArea.addSubview(discriptionTextField)
        
        //Adding datePickerView
        deadline = UIDatePicker(frame: datePickerRect)
        deadline.datePickerMode = .dateAndTime
        deadline.layer.cornerRadius = 10
        deadline.layer.masksToBounds = true
        deadline.layer.borderColor = borderColor.cgColor
        deadline.layer.borderWidth = 1
        deadline.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        deadline.isEnabled = false
        contentArea.addSubview(deadline)
        
        //Adding deadline Switcher
        deadlineSwitcher = UISwitch(frame: deadlineSwitcherRect)
        deadlineSwitcher.addTarget(self, action: #selector(deadlineSwicherDidChanged(sender:)), for: .valueChanged)
        contentArea.addSubview(deadlineSwitcher)
        
        //Adding buttons
        //open|close button
        openCloseButton = UIButton(frame: collapsedOpenCloseButtonRect)
        openCloseButton.layer.cornerRadius = self.openCloseButton.frame.size.height / 2
        openCloseButton.backgroundColor = UIColor.green
        openCloseButton.layer.cornerRadius = openCloseButton.frame.height / 2
        openCloseButton.layer.masksToBounds = true
        openCloseButton.layer.borderColor = borderColor.cgColor
        openCloseButton.layer.borderWidth = 2
        openCloseButton.addTarget(self, action: #selector(openCloseButtonAction(sender:)), for: .touchUpInside)
        let panGesture: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.panGestureAction(sender:)))
        openCloseButton.addGestureRecognizer(panGesture)
        
        contentArea.addSubview(openCloseButton)
        
        //Adiing Done mark button
        doneMarkButton = UIButton(frame: hidenMarkBtnRect)
        doneMarkButton.backgroundColor = UIColor.green
        doneMarkButton.layer.borderColor = UIColor.orange.cgColor
        doneMarkButton.layer.borderWidth = 2
        doneMarkButton.layer.cornerRadius = doneMarkButton.frame.height / 2
        doneMarkButton.layer.masksToBounds = true
        
        let donePath = UIBezierPath()
        donePath.move(to: CGPoint(x: 5, y: 12))
        donePath.addLine(to: CGPoint(x: 11, y: 20))
        donePath.addLine(to: CGPoint(x: 22, y: 8))
        
            let doneShape = CAShapeLayer()
        doneShape.path = donePath.cgPath
        doneShape.strokeColor = UIColor.orange.cgColor
        doneShape.fillColor = nil
        doneShape.strokeEnd = 1
        doneShape.lineWidth = 3
        doneShape.lineCap = .round
        doneMarkButton.layer.addSublayer(doneShape)
        doneMarkButton.addTarget(self, action: #selector(doneButtonAction(sender:)), for: .touchUpInside)
        
        contentArea.addSubview(doneMarkButton)
        
    }
    
    @objc func panGestureAction(sender: UIPanGestureRecognizer) {
        guard let view = sender.view, sender.view?.backgroundColor == UIColor.red else { return }
        let translate = sender.translation(in: self)
        view.center = CGPoint(x: view.center.x + translate.x, y: view.center.y)
        sender.setTranslation(CGPoint.zero, in: self)
        
        let distanseToFirstPosition = view.center.x - 25
        let distanseToSecondPosition = 275 - view.center.x
        
        if sender.state == .ended {
            if distanseToFirstPosition > distanseToSecondPosition {
                UIView.transition(with: self, duration: 0.5, options: [.curveEaseInOut, .allowUserInteraction], animations: { [unowned self] in
                    view.center = CGPoint(x: 275, y: view.center.y)
                    self.swipeToDiscriptionMode()
                }) { [unowned self] animated in
//                    self.deadline.isHidden = true
//                    self.deadlineSwitcher.isHidden = true
                }
            } else {
                UIView.transition(with: self, duration: 0.5, options: [.curveEaseInOut, .allowUserInteraction], animations: { [unowned self] in
                    view.center = CGPoint(x: 25, y: view.center.y)
                    self.swipeToDatePickerMode()
                }) { [unowned self] animated in
//                    self.deadline.isHidden = false
//                    self.deadlineSwitcher.isHidden = false
                }
            }
        }
    }
    
    @objc func deadlineSwicherDidChanged(sender: UISwitch) {
        if sender.isOn {
            deadline.isEnabled = true
        } else {
            deadline.isEnabled = false
        }
    }
    
    private func setValues() {
        guard let model = squareModel else { return }
            titleTextField.text = model.squareTitle
            discriptionTextField.text = model.squareDiscription
        guard let _deadLine_ = model.deadLine else { return }
        deadlineSwitcher.isOn = true
        deadline.isEnabled = true
        deadline.date = _deadLine_
    }
    
    //MARK: - Mode switchers
    
    private func switchToClosedMode() {
        self.titleTextField.isEnabled = false
        self.discriptionTextField.isEditable = false
        self.openCloseButton.backgroundColor = UIColor.green
        //        self.actionButton.setTitle("Open", for: .normal)
        
        UIView.transition(with: self, duration: 0.5, options: [.curveEaseInOut, .allowUserInteraction], animations: { [unowned self] in
            self.swipeToDiscriptionMode()
            self.titleTextField.frame.size = self.closedTitleRect.size
            self.discriptionTextField.alpha = 0
            self.openCloseButton.frame.size = self.collapsedOpenCloseButtonRect.size
            self.openCloseButton.layer.cornerRadius = self.openCloseButton.frame.size.height / 2
            self.openCloseButton.center = CGPoint(x: self.collapsedOpenCloseButtonRect.midX, y: self.collapsedOpenCloseButtonRect.midY)
            self.doneMarkButton.frame = self.hidenMarkBtnRect
            self.contentArea.frame.size = self.closedContentArea.size
            self.frame.size = self.closedContentArea.size
        })
    }
    
    private func switchToDiscriptionMode() {
        self.titleTextField.isEnabled = true
        self.discriptionTextField.isEditable = true
        self.openCloseButton.backgroundColor = UIColor.red
        UIView.transition(with: self, duration: 0.5, options: [.curveEaseInOut, .allowUserInteraction], animations: { [unowned self] in
            self.titleTextField.frame.size = self.openedTitleRect.size
            self.discriptionTextField.alpha = 1
            self.openCloseButton.frame.size = self.defaultOpenCloseButtonRect.size
            self.openCloseButton.layer.cornerRadius = self.openCloseButton.frame.size.width / 2
            self.openCloseButton.frame.origin = self.defaultOpenCloseButtonRect.origin
            self.doneMarkButton.frame = self.shawnMarkBtnInactive
            self.contentArea.frame.size = self.openedContentArea.size
            self.frame.size = self.openedContentArea.size
            }, completion: { _ in
                print("opening animation did completed")
        })
    }
    
    private func swipeToDatePickerMode() {
        discriptionTextField.center.x = -(discriptionTVRect.width / 2) - 5
        deadline.center.x = (datePickerRect.width / 2) + 5
        deadlineSwitcher.frame.origin.x = 240
    }
    
    private func swipeToDiscriptionMode() {
        discriptionTextField.center.x = (discriptionTVRect.width / 2) + 5
        deadline.frame.origin.x = defPickerViewsHidenXPosition
        deadlineSwitcher.frame.origin.x = defSwitcherViewHidenXPosition
        
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
                
                let settingsButtonLayersAnimation = CAKeyframeAnimation(keyPath: "strokeEnd")
                settingsButtonLayersAnimation.duration = 1
                settingsButtonLayersAnimation.values = [0.000, 1.000] as [Float]
                settingsButtonLayersAnimation.keyTimes = [0.000, 1.000] as [NSNumber]
                settingsButtonLayersAnimation.timingFunctions = [linearTiming, linearTiming]
                settingsButtonLayersAnimation.beginTime = 0
                settingsButtonLayersAnimation.isRemovedOnCompletion = false
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
    
    
    // - MARK: Buttons actions
    @objc func doneButtonAction(sender: UIButton) {
        guard let model = squareModel else { return }
        print("Setting 'done state' to object")
        let delegate = UIApplication.shared.delegate as? AppDelegate
        delegate?.scheduleNotification(notificationType: "Notification")
    }
    
    @objc func openCloseButtonAction(sender: UIButton) {
        if openCloseButton.backgroundColor == UIColor.red {
            guard let model = squareModel else { return }
            model.saveItem(xPosition: Float(self.convert(self.frame.origin, to: superview).x) / 2, yPosition: Float(self.convert(self.frame.origin, to: superview).y) / 2, isFinished: false)
            switchToClosedMode()
        } else {
            switchToDiscriptionMode()
        }
    }
}
