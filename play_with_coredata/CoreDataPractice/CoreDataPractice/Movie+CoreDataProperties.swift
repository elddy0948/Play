//
//  Movie+CoreDataProperties.swift
//  CoreDataPractice
//
//  Created by 김호준 on 2023/01/18.
//
//

import UIKit
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var releaseDate: Date?
    @NSManaged public var rating: Double
    @NSManaged public var duration: Int64
    @NSManaged public var watched: Bool
    @NSManaged public var posterImage: UIImage?

}

extension Movie : Identifiable {

}
