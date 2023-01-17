import CoreData

class StorageProvider {
  private let persistentContainer: NSPersistentContainer
  
  init(name: String) {
    ValueTransformer.setValueTransformer(UIImageTransformer(),
                                         forName: NSValueTransformerName("UIImageTransformer"))
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
    movie.title = name
    
    do {
      try persistentContainer.viewContext.save()
      print("Movie saved successfully!")
    } catch {
      persistentContainer.viewContext.rollback()
      print("Failed to save movie : \(error)")
    }
  }
  
  func getAllMovies() -> [Movie] {
    let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
    do {
      return try persistentContainer.viewContext.fetch(fetchRequest)
    } catch {
      print("Failed to fetch all movies : \(error)")
      return []
    }
  }
  
  func deleteMovie(_ movie: Movie) {
    persistentContainer.viewContext.delete(movie)
    
    do {
      try persistentContainer.viewContext.save()
    } catch {
      persistentContainer.viewContext.rollback()
      print("Failed to save context: \(error)")
    }
  }
  
  func updateMovie() {
    do {
      try persistentContainer.viewContext.save()
    } catch {
      persistentContainer.viewContext.rollback()
      print("Failed to save context: \(error)")
    }
  }
}
