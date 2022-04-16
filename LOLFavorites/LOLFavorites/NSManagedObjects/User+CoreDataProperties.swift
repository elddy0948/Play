//
//  User+CoreDataProperties.swift
//  LOLFavorites
//
//  Created by 김호준 on 2022/04/16.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var favoriteChamps: NSOrderedSet?

}

// MARK: Generated accessors for favoriteChamps
extension User {

    @objc(insertObject:inFavoriteChampsAtIndex:)
    @NSManaged public func insertIntoFavoriteChamps(_ value: Champion, at idx: Int)

    @objc(removeObjectFromFavoriteChampsAtIndex:)
    @NSManaged public func removeFromFavoriteChamps(at idx: Int)

    @objc(insertFavoriteChamps:atIndexes:)
    @NSManaged public func insertIntoFavoriteChamps(_ values: [Champion], at indexes: NSIndexSet)

    @objc(removeFavoriteChampsAtIndexes:)
    @NSManaged public func removeFromFavoriteChamps(at indexes: NSIndexSet)

    @objc(replaceObjectInFavoriteChampsAtIndex:withObject:)
    @NSManaged public func replaceFavoriteChamps(at idx: Int, with value: Champion)

    @objc(replaceFavoriteChampsAtIndexes:withFavoriteChamps:)
    @NSManaged public func replaceFavoriteChamps(at indexes: NSIndexSet, with values: [Champion])

    @objc(addFavoriteChampsObject:)
    @NSManaged public func addToFavoriteChamps(_ value: Champion)

    @objc(removeFavoriteChampsObject:)
    @NSManaged public func removeFromFavoriteChamps(_ value: Champion)

    @objc(addFavoriteChamps:)
    @NSManaged public func addToFavoriteChamps(_ values: NSOrderedSet)

    @objc(removeFavoriteChamps:)
    @NSManaged public func removeFromFavoriteChamps(_ values: NSOrderedSet)

}

extension User : Identifiable {

}
