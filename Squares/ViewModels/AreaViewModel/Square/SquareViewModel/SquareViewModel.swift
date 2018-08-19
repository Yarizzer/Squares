//
//  SquareViewModel.swift
//  Squares
//
//  Created by Yaroslav Abaturov on 17/08/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation

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
    var squareTitle: String {
        guard let squareTitle = squareItem?.title else { return "<square name not set>" }
        return squareTitle
    }
    
    var squareDiscription: String {
        guard let discription = squareItem?.discription else { return "<square discription not set>" }
        return discription
    }
    
    func getSquareView() -> SquareView {
        return squareView
    }
    
    func terminateItem() {
        squareView.animateTerminating()
        
    }
}
