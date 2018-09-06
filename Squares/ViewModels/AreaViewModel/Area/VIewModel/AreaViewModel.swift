//
//  AreaViewModel.swift
//  Squares
//
//  Created by Yaroslav Abaturov on 16/08/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation
import UIKit

class AreaViewModel {
    private var areaEntity: Area
    var areaView: UIView?
    
    private func setupAreaProperties() {
        let _areaView_ = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: UIScreen.main.bounds.size.width * 2, height: UIScreen.main.bounds.size.height * 2)))
        
        _areaView_.tag = 1
        _areaView_.sizeToFit()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        let startGradientColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
        let endGradientColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        gradientLayer.colors = [startGradientColor.cgColor, endGradientColor.cgColor]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: _areaView_.bounds.size.width, height: _areaView_.bounds.size.height)
        
        _areaView_.layer.addSublayer(gradientLayer)
        
        _areaView_.layer.cornerRadius = 5
        _areaView_.layer.masksToBounds = true
        let borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        _areaView_.layer.borderColor = borderColor.cgColor
        _areaView_.layer.borderWidth = 1
        
        self.areaView = _areaView_
        
        populateAllExistingSquares()
    }
    
    private func setupAreaGestures() {
        guard let _view_ = areaView else { return }
        let areaTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.areaTapGestureAction(sender:)))
        areaTapGesture.numberOfTapsRequired = 1
        _view_.addGestureRecognizer(areaTapGesture)
    }
    
    private func populateAllExistingSquares() {
        let arrayOfSquares = areaEntity.relationWithSquares?.allObjects as! [Square]
        for i in arrayOfSquares {
            let squareModel = SquareViewModel(withAreaItem: areaEntity, squareEntity: i)
            let squareView = squareModel.getSquareView()
            addGestures(toSquareView: squareView)
            squareView.frame.origin = CGPoint(x: CGFloat(i.xPosition), y: CGFloat(i.yPosition))
            areaView?.addSubview(squareView)
        }
    }
    
    // MARK: - Gesture section
    @objc private func areaTapGestureAction(sender: UIGestureRecognizer) {
        //Creation a square here
        let point = sender.location(in: areaView)
        if sender.view?.tag == 1 {
            let squareModel = SquareViewModel(withAreaItem: areaEntity, squareEntity: nil)
            
            let newSquare = squareModel.getSquareView()
            addGestures(toSquareView: newSquare)
            
            newSquare.center = point
            guard let _view_ = areaView else { return }
            _view_.addSubview(newSquare)
        }
    }
    
    private func addGestures(toSquareView squareView: SquareView) {
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapGestureAction(sender:)))
        let deleteTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.deletionGestureAction(sender:)))
        deleteTapGesture.numberOfTapsRequired = 2
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.panGestureAction(sender:)))
        
        squareView.addGestureRecognizer(tapGesture)
        squareView.addGestureRecognizer(deleteTapGesture)
        squareView.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc func tapGestureAction(sender: UITapGestureRecognizer) {
        //create action with one tap
    }
    
    @objc private func deletionGestureAction(sender: UIGestureRecognizer) {
        if let view = sender.view as? SquareView {
            guard let viewModel = view.squareModel else { return }
            viewModel.terminateItem()
        }
    }
//
    @objc private func panGestureAction(sender: UIPanGestureRecognizer) {
        guard let view = sender.view as? SquareView else { return }
        if sender.state == .began {
//            view.animateLiftUp()
        }
        let translate = sender.translation(in: areaView)
        view.center = CGPoint(x: (sender.view?.center.x)! + translate.x, y: (sender.view?.center.y)! + translate.y)
        sender.setTranslation(CGPoint.zero, in: areaView)
        if sender.state == .ended {
            guard let squareViewModel = view.squareModel else { return }
            squareViewModel.updateItemPosition(xPosition: Float(view.frame.origin.x), yPosition: Float(view.frame.origin.y))
        }
    }
    
    
    init(forArea _area_: Area) {
        self.areaEntity = _area_
        setupAreaProperties()
        setupAreaGestures()
    }
}

extension AreaViewModel: AreaViewModelType {
    func getAreaView() -> UIView {
        guard let _areaView_ = self.areaView else { return UIView() }
        return _areaView_
    }
    
    func getContentSize() -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width * 2, height: UIScreen.main.bounds.size.height * 2)
    }
}
