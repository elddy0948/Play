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

extension StorageProvider {
  func saveMovie(named name: String) {
    let movie = Movie(context: persistentContainer.viewContext)
    movie.name = name
    
    do {
      try persistentContainer.viewContext.save()
      print("Movie saved successfully!")
    } catch {
      persistentContainer.viewContext.rollback()
      print("Failed to save movie : \(error)")
    }
  }
}
