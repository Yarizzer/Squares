//
//  SquareViewModel.swift
//  Squares
//
//  Created by Yaroslav Abaturov on 17/08/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation
import UIKit

class SquareViewModel {
    var areaItem: Area
    var squareItem: Square?
    
    private var squareView = SquareView()
    
    init(withAreaItem areaItem: Area, squareEntity square: Square?) {
        self.areaItem = areaItem
        self.squareItem = square
        self.squareView = SquareView(withModel: self)
    }
}

extension SquareViewModel: SquareViewModelType {
    //needs to scheck new model for squareView
    var squareItemsExists: Bool {
        return squareItem == nil ? false : true
    }
    //needs to return a title
    var squareTitle: String {
        guard let squareTitle = squareItem?.title else { return "" }
        return squareTitle
    }
    //needs to return a discription
    var squareDiscription: String {
        guard let discription = squareItem?.discription else { return "" }
        return discription
    }
    //needs to return a deadline
    var deadLine: Date? {
        guard let deadLine = squareItem?.deadLine as Date? else { return nil }
        return deadLine
    }
    //needs to return a view
    func getSquareView() -> SquareView {
        return squareView
    }
    
    func updateItemPosition(xPosition _xPosition_: Float, yPosition _yPosition_: Float) {
        var deadLine: Date? {
            guard let _deadLine_ = (squareItem?.deadLine as Date?) else { return nil }
            return _deadLine_
        }
        var isFinished: Bool {
            guard let finished = squareItem?.isFinished else { return false }
            return finished
        }
        saveItem(xPosition: _xPosition_, yPosition: _yPosition_, isFinished: isFinished)
    }
    
    func saveItem(xPosition _xPosition_: Float, yPosition _yPosition_: Float, isFinished _finished_: Bool) {
        
        let demands = SquareDemands(wihtArea: areaItem,
                                    square: squareItem,
                                    squareXPosition: _xPosition_,
                                    squareYPosition: _yPosition_,
                                    title: squareView.titleTextField.text ?? "",
                                    discription: squareView.discriptionTextField.text ?? "",
                                    deadLine: squareView.deadlineSwitcher.isOn ? squareView.deadline.date : nil,
                                    isFinished: _finished_)
        self.squareItem = MainDBManager.shared.performARecordForSquare(withDemands: demands)
    }
    
    func terminateItem() {
        if let _square_ = squareItem {
            MainDBManager.shared.removeSquareRecordFromDB(forSquare: _square_)
            squareView.animateTerminating()
        } else {
            squareView.animateTerminating()
        }
    }
}
