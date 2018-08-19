//
//  SquareViewModelType.swift
//  Squares
//
//  Created by Yaroslav Abaturov on 17/08/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation

protocol SquareViewModelType {
    var squareTitle: String { get }
    var squareDiscription: String { get }
    func getSquareView() -> SquareView
    func terminateItem()
}
