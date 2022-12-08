//
//  CDPost+CoreDataProperties.swift
//  CoreDataMVVM
//
//  Created by 김호준 on 2022/05/16.
//
//

import Foundation
import CoreData


extension CDPost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPost> {
        return NSFetchRequest<CDPost>(entityName: "CDPost")
    }

    @NSManaged public var title: String?
    @NSManaged public var body: String?
    @NSManaged public var createdAt: String?
    @NSManaged public var uid: String?

}

extension CDPost : Identifiable {

}
