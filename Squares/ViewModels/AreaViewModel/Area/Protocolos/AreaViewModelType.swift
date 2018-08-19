//
//  AreaViewModelType.swift
//  Squares
//
//  Created by Yaroslav Abaturov on 16/08/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation
import UIKit

protocol AreaViewModelType {
    func getAreaView() -> UIView
    func getContentSize() -> CGSize
}
