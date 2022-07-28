import CoreData
import Foundation

final class CoreDataStack {
  private let storeCoordinator: NSPersistentStoreCoordinator
  let context: NSManagedObjectContext
  
  public init() {
    let bundle = Bundle(for: CoreDataStack.self)
    guard let url = bundle.url(forResource: "TodoDataModel", withExtension: "momd"),
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
    
    let storeURL = url.appendingPathComponent("TodoDataModel.sqlite")
    
    do {
      try storeCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                              configurationName: nil,
                                              at: storeURL,
                                              options: nil)
    } catch {
      fatalError("Error migrating store : \(error.localizedDescription)")
    }
  }
}
