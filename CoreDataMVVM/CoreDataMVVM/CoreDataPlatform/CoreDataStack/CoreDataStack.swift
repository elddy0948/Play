import Foundation
import CoreData

final class CoreDataStack {
  private let storeCoordinator: NSPersistentStoreCoordinator
  let context: NSManagedObjectContext
  
  init() {
    let bundle = Bundle(for: CoreDataStack.self)
    guard let url = bundle.url(forResource: "Model", withExtension: "momd"),
          let model = NSManagedObjectModel(contentsOf: url) else {
      fatalError()
    }
    
    self.storeCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
    self.context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    self.context.persistentStoreCoordinator = self.storeCoordinator
    self.migrateStore()
  }
  
  private func migrateStore() {
    guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
      fatalError()
    }
    let storeURL = url.appendingPathComponent("Model.sqlite")
    
    do {
      try storeCoordinator.addPersistentStore(
        ofType: NSSQLiteStoreType,
        configurationName: nil,
        at: storeURL,
        options: nil
      )
    } catch let error {
      fatalError("Error migrating store: \(error)")
    }
  }
}
