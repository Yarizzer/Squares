//
//  AreaListViewModel.swift
//  Squares
//
//  Created by Yaroslav Abaturov on 14/08/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation

class AreaListViewModel {
    private var arrayOfAreas = [Area]()
    private var currentIndexPath: IndexPath?
    
    init() {
        updateAreasArray() 
    }
}

extension AreaListViewModel: AreaListViewModelType {
    func updateAreasArray() {
        arrayOfAreas = MainDBManager.shared.getArrayOfAreas()
    }
    
    func getAreasCount() -> Int {
        return arrayOfAreas.count
    }
    
    func updateCurrentIndexPath(withIndexPath _indexPath_: IndexPath) {
        currentIndexPath = _indexPath_
    }
    
    func getAreaNameForEditingRow() -> String {
        guard let curIndexPath = currentIndexPath, let areaName = arrayOfAreas[curIndexPath.row].name else { return "" }
        return areaName
    }
    
    func getModelForCell(atIndexPath indexPath: IndexPath) -> AreaListCellViewModelType? {
        let area = arrayOfAreas[indexPath.row]
        return AreaListCellViewModel(withArea: area)
    }
    
    func peformARecordForAreaInDB(withTitle _title_: String, recordKey recKey: String) {
        if recKey == "_Creation_" {
            let demands = AreaDemands(withTitle: _title_, foraArea: nil, withOrder: arrayOfAreas.count + 1)
            MainDBManager.shared.peformARecordForAreaInDB(withDemands: demands)
        } else if recKey == "_Editing_" {
            guard let curIndexPath = currentIndexPath else { return }
            let area = arrayOfAreas[curIndexPath.row]
            print(curIndexPath.row)
            let demands = AreaDemands(withTitle: _title_, foraArea: area, withOrder: curIndexPath.row + 1)
            MainDBManager.shared.peformARecordForAreaInDB(withDemands: demands)
        }
    }
    
    func removeAreaRecordFromDB() {
        guard let currIndex = currentIndexPath else { return }
        let area = arrayOfAreas[currIndex.row]
        MainDBManager.shared.removeAreaRecordFromDB(forArea: area)
        updateAreasArray()
    }
    
    func getModelForAreaVC() -> AreaViewModelType? {
        guard let curIndexPath = currentIndexPath else { return nil }
        return AreaViewModel(forArea: arrayOfAreas[curIndexPath.row])
    }
}
