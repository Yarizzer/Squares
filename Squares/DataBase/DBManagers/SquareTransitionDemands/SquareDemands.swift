//
//  SquareDemands.swift
//  Squares
//
//  Created by Yaroslav Abaturov on 21/08/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation

class SquareDemands {
    
    var square: Square?
    
    var relationWithArea: Area?
    var title: String
    var discription: String
    var deadLine: NSDate?
    var isFinished: Bool
    var xPosition: Float
    var yPosition: Float
    
    init(wihtArea _area_: Area, square _square_: Square?, squareXPosition _xPosition_: Float, squareYPosition _yPosition_: Float, title _title_: String, discription _discription_: String, deadLine _deadLine_: Date?, isFinished _finished_: Bool) {
        self.relationWithArea = _area_
        self.square = _square_
        self.title = _title_
        self.discription = _discription_
        self.xPosition = _xPosition_
        self.yPosition = _yPosition_
        self.deadLine = _deadLine_ as NSDate?
        self.isFinished = _finished_
    }
}
