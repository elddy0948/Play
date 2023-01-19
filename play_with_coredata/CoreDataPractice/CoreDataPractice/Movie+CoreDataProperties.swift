import UIKit
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var duration: Int64
    @NSManaged public var posterImage: UIImage?
    @NSManaged public var rating: Double
    @NSManaged public var releaseDate: Date?
    @NSManaged public var title: String?
    @NSManaged public var watched: Bool
    @NSManaged public var cast: NSSet?
    @NSManaged public var characters: NSSet?

}

// MARK: Generated accessors for cast
extension Movie {

    @objc(addCastObject:)
    @NSManaged public func addToCast(_ value: Actor)

    @objc(removeCastObject:)
    @NSManaged public func removeFromCast(_ value: Actor)

    @objc(addCast:)
    @NSManaged public func addToCast(_ values: NSSet)

    @objc(removeCast:)
    @NSManaged public func removeFromCast(_ values: NSSet)

}

// MARK: Generated accessors for characters
extension Movie {

    @objc(addCharactersObject:)
    @NSManaged public func addToCharacters(_ value: Character)

    @objc(removeCharactersObject:)
    @NSManaged public func removeFromCharacters(_ value: Character)

    @objc(addCharacters:)
    @NSManaged public func addToCharacters(_ values: NSSet)

    @objc(removeCharacters:)
    @NSManaged public func removeFromCharacters(_ values: NSSet)

}

extension Movie : Identifiable {

}
