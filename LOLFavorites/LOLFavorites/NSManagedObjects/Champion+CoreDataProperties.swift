//
//  Champion+CoreDataProperties.swift
//  LOLFavorites
//
//  Created by 김호준 on 2022/04/16.
//
//

import Foundation
import CoreData


extension Champion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Champion> {
        return NSFetchRequest<Champion>(entityName: "Champion")
    }

    @NSManaged public var name: String?
    @NSManaged public var gender: String?
    @NSManaged public var lane: String?
    @NSManaged public var user: User?

}

extension Champion : Identifiable {

}
