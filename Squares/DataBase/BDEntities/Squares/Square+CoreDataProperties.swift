//
//  Square+CoreDataProperties.swift
//  Squares
//
//  Created by Yarr!zzeR on 23/08/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//
//

import Foundation
import CoreData


extension Square {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Square> {
        return NSFetchRequest<Square>(entityName: "Square")
    }

    @NSManaged public var creationDate: NSDate?
    @NSManaged public var deadLine: NSDate?
    @NSManaged public var discription: String?
    @NSManaged public var isFinished: Bool
    @NSManaged public var title: String?
    @NSManaged public var xPosition: Float
    @NSManaged public var yPosition: Float
    @NSManaged public var relationWithArea: Area?

}
