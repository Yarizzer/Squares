//
//  Square+CoreDataProperties.swift
//  Squares
//
//  Created by Yaroslav Abaturov on 17/08/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//
//

import Foundation
import CoreData


extension Square {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Square> {
        return NSFetchRequest<Square>(entityName: "Square")
    }

    @NSManaged public var deadLine: NSDate?
    @NSManaged public var discription: String?
    @NSManaged public var isFinished: Bool
    @NSManaged public var title: String?
    @NSManaged public var relationWithArea: Area?

}
