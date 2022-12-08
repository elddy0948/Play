import Foundation
import CoreData
import RxSwift
import QueryKit

extension CDPost {
  static var title: Attribute<String> {
    return Attribute("title")
  }
  
  static var body: Attribute<String> {
    return Attribute("body")
  }
  
  static var uid: Attribute<String> {
    return Attribute("uid")
  }
  
  static var createdAt: Attribute<String> {
    return Attribute("createdAt")
  }
}

extension CDPost: DomainConvertibleType {
  func asDomain() -> Post {
    return Post(
      title: title!, body: body!, uid: uid!, createdAt: createdAt!
    )
  }
}

extension CDPost: Persistable {
  static var entityName: String {
    return "CDPost"
  }
}

extension Post: CoreDataRepresentable {
  typealias CoreDataType = CDPost
  
  func update(entity: CoreDataType) {
    entity.uid = uid
    entity.title = title
    entity.body = body
    entity.createdAt = createdAt
  }
}
