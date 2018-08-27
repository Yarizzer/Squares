//
//  Area+CoreDataProperties.swift
//  Squares
//
//  Created by Yaroslav Abaturov on 21/08/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//
//

import Foundation
import CoreData


extension Area {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Area> {
        return NSFetchRequest<Area>(entityName: "Area")
    }

    @NSManaged public var creationDate: NSDate?
    @NSManaged public var name: String?
    @NSManaged public var order: Int16
    @NSManaged public var relationWithSquares: NSSet?

}

// MARK: Generated accessors for relationWithSquares
extension Area {

    @objc(addRelationWithSquaresObject:)
    @NSManaged public func addToRelationWithSquares(_ value: Square)

    @objc(removeRelationWithSquaresObject:)
    @NSManaged public func removeFromRelationWithSquares(_ value: Square)

    @objc(addRelationWithSquares:)
    @NSManaged public func addToRelationWithSquares(_ values: NSSet)

    @objc(removeRelationWithSquares:)
    @NSManaged public func removeFromRelationWithSquares(_ values: NSSet)

}
