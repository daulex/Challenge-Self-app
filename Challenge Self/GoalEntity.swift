//
//  GoalEntity.swift
//  Challenge Self
//
//  Created by Kirills Galenko on 27/08/2024.
//

import CoreData

@objc(GoalEntity)
public class GoalEntity: NSManagedObject {
    @NSManaged public var title: String?
    @NSManaged public var complete: Bool
    @NSManaged public var order: Int16
}
