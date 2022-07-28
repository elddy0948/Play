import CoreData
import Foundation

protocol AbstractRepository {
  associatedtype T
  
  func query(with predicate: NSPredicate?,
             sortDescriptors: [NSSortDescriptor]?,
             completion: @escaping (Result<[T], Error>) -> Void)
  func save(entity: T, completion: @escaping (Result<Void, Error>) -> Void)
  func delete(entity: T, completion: @escaping (Result<Void, Error>) -> Void)
}
