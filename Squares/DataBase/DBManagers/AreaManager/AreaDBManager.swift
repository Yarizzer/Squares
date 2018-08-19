//
//  AreaDBManager.swift
//  Squares
//
//  Created by Yaroslav Abaturov on 14/08/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AreaDBManager {
    
    static let shared = AreaDBManager()
    
    private init() {}
    
    func getArrayOfAreas() -> Array<Area> {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Area> = Area.fetchRequest()
        
        var arrayToReturn = [Area]()
        do {
            let arrayOfAreasInDataBase = try context.fetch(fetchRequest)
            guard !arrayOfAreasInDataBase.isEmpty else { return arrayToReturn }
            arrayToReturn = arrayOfAreasInDataBase.sorted {$0.order < $1.order }
        } catch {
            print(error.localizedDescription)
        }
        return arrayToReturn
    }
    
    func peformARecordForAreaInDB(withDemands _demands_: AreaDemands) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        if let area = _demands_.area {
            let fetchRequest: NSFetchRequest<Area> = Area.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "SELF = %@", area)
            do {
                let entity = try context.fetch(fetchRequest).first
                entity?.name = _demands_.areaTitle
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        } else {
            let entity = NSEntityDescription.entity(forEntityName: "Area", in: context)
            let areaObject = NSManagedObject(entity: entity!, insertInto: context) as! Area
            areaObject.name = _demands_.areaTitle
            areaObject.order = Int16(_demands_.order)
            let date = Date() as NSDate
            areaObject.creationDate = date
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    private func reindexOrder() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Area> = Area.fetchRequest()
        do {
            let arrayOfAreas = try context.fetch(fetchRequest).sorted{ $0.order < $1.order}
            guard !arrayOfAreas.isEmpty else { return }
            var c = 0
            for i in arrayOfAreas {
                c += 1
                i.order = Int16(c)
            }
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    
    func removeARecordFromDB(forArea _area_: Area) {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        
        let fetchRequest: NSFetchRequest<Area> = Area.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "SELF = %@", _area_.objectID)
        
        do {
            
            for area in try context.fetch(fetchRequest) {
                context.delete(area)
            }
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        reindexOrder()
        
    }

}
