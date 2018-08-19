//
//  AreaListCellViewModel.swift
//  Squares
//
//  Created by Yaroslav Abaturov on 14/08/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation

class AreaListCellViewModel {
    private var area: Area
    init(withArea _area_: Area) {
        self.area = _area_
    }
}

extension AreaListCellViewModel: AreaListCellViewModelType {
    func getAreaName() -> String {
        guard let _areaName_ = area.name else { return "name not set" }
        return _areaName_
    }
    func getAreaCreationDate() -> String {
        guard let _date_ = area.creationDate else { return "date is not set" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        return dateFormatter.string(from: _date_ as Date)
        
    }
}
