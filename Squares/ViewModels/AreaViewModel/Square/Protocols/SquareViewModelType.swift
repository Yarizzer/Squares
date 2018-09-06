//
//  SquareViewModelType.swift
//  Squares
//
//  Created by Yaroslav Abaturov on 17/08/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation

protocol SquareViewModelType {
    var squareItemsExists: Bool { get }
    var squareTitle: String { get }
    var squareDiscription: String { get }
    var deadLine: Date? { get }
    func getSquareView() -> SquareView
    func updateItemPosition(xPosition _xPosition_: Float, yPosition _yPosition_: Float)
    func saveItem(xPosition _xPosition_: Float, yPosition _yPosition_: Float, isFinished _finished_: Bool)
    func terminateItem()
}
