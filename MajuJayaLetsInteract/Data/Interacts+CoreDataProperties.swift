//
//  Interacts+CoreDataProperties.swift
//  MajuJayaLetsInteract
//
//  Created by Raja Azian on 28/04/21.
//
//

import Foundation
import CoreData


extension Interacts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Interacts> {
        return NSFetchRequest<Interacts>(entityName: "Interacts")
    }

    @NSManaged public var name: String?
    @NSManaged public var reflections: String?
    @NSManaged public var date: Date?

}

extension Interacts : Identifiable {

}
