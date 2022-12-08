import Foundation
import CoreData
import RxSwift

final class FetchedResultsControllerEntityObserver<T: NSFetchRequestResult>: NSObject, NSFetchedResultsControllerDelegate {
  typealias Observer = AnyObserver<[T]>
  
  let observer: Observer
  let bag = DisposeBag()
  let fetchedResultsController: NSFetchedResultsController<T>
  
  init(observer: Observer,
       fetchRequest: NSFetchRequest<T>,
       managedObjectContext context: NSManagedObjectContext,
       sectionNameKeyPath: String?,
       cacheName: String?) {
    self.observer = observer
    self.fetchedResultsController = NSFetchedResultsController(
      fetchRequest: fetchRequest,
      managedObjectContext: context,
      sectionNameKeyPath: sectionNameKeyPath,
      cacheName: cacheName
    )
    
    super.init()
    
    context.perform {
      self.fetchedResultsController.delegate = self
      do {
        try self.fetchedResultsController.performFetch()
      } catch let error {
        observer.on(.error(error))
      }
      self.sendNextElement()
    }
  }
  
  func sendNextElement() {
    self.fetchedResultsController.managedObjectContext.perform {
      let entities = self.fetchedResultsController.fetchedObjects ?? []
      self.observer.on(.next(entities))
    }
  }
  
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    sendNextElement()
  }
}

extension FetchedResultsControllerEntityObserver: Disposable {
  func dispose() {
    fetchedResultsController.delegate = nil
  }
}
