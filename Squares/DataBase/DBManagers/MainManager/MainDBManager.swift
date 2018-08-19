//
//  MainDBManager.swift
//  Squares
//
//  Created by Yaroslav Abaturov on 14/08/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation

class MainDBManager {
    static let shared = MainDBManager()
    
    private init() {}
    
    func getArrayOfAreas() -> Array<Area> {
        return AreaDBManager.shared.getArrayOfAreas()
    }
    
    func peformARecordForAreaInDB(withDemands _demands_ : AreaDemands) {
        AreaDBManager.shared.peformARecordForAreaInDB(withDemands: _demands_)
    }
    
    func removeARecordFromDB(forArea _area_: Area) {
        AreaDBManager.shared.removeARecordFromDB(forArea: _area_)
    }
}
