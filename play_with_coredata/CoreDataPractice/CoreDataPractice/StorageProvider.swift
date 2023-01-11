import CoreData

class StorageProvider {
  private let persistentContainer: NSPersistentContainer
  
  init(name: String) {
    persistentContainer = NSPersistentContainer(name: name)
    persistentContainer.loadPersistentStores(completionHandler: { description, error in
      if let error = error {
        fatalError("Core Data store failed to load with error: \(error)")
      }
    })
  }
}
