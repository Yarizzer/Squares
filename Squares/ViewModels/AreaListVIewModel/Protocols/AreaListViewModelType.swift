//
//  AreaListViewModelType.swift
//  Squares
//
//  Created by Yaroslav Abaturov on 14/08/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation

protocol AreaListViewModelType {
    func updateAreasArray()
    
    func getAreasCount() -> Int
    func updateCurrentIndexPath(withIndexPath _indexPath_: IndexPath)
    func getAreaNameForEditingRow() -> String
    func getModelForCell(atIndexPath indexPath: IndexPath) -> AreaListCellViewModelType?
    func peformARecordForAreaInDB(withTitle _title_: String, recordKey recKey: String)
    func removeAreaRecordFromDB()
    
    func getModelForAreaVC() -> AreaViewModelType?
}
