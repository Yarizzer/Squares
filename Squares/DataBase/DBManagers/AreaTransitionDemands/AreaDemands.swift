//
//  AreaDemands.swift
//  Squares
//
//  Created by Yaroslav Abaturov on 15/08/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation

class AreaDemands {
    var area: Area?
    var areaTitle: String
    var order: Int
    
    init(withTitle _title_: String, foraArea _area_: Area?, withOrder _order_: Int) {
        self.area = _area_
        self.areaTitle = _title_
        self.order = _order_
    }
}
