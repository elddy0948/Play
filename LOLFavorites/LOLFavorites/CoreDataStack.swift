import Foundation
import CoreData

final class CoreDataStack {
  private let entityName: String
  
  private lazy var container: NSPersistentContainer = {
    let container = NSPersistentContainer(name: self.entityName)
    container.loadPersistentStores(completionHandler: { (description, error) in
      if let error = error {
        print("Can't load persistent stores \(error)")
        return
      }
      print(description)
    })
    return container
  }()
  
  lazy var managedObjectContext: NSManagedObjectContext = {
    return container.viewContext
  }()
  
  init(entityName: String) {
    self.entityName = entityName
  }
  
  func saveContext() {
    guard managedObjectContext.hasChanges else { return }
    do {
      try managedObjectContext.save()
    } catch let error as NSError {
      print("Failed to save \(error), \(error.userInfo)")
    }
  }
}
