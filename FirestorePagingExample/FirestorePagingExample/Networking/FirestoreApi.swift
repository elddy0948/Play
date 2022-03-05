import Foundation
import Firebase
import FirebaseFirestoreSwift

final class FirestoreApi {
  
  private let fireStore = Firestore.firestore()
  private var query: Query? = nil {
    didSet {
      print(self.query)
    }
  }
  
  func fetchGreetings(completion: @escaping ([CellModel]) -> Void) {
    let collection = fireStore.collection("cells")
    let requestQuery: Query
    
    if let query = query {
      //There is last query
      requestQuery = query
    } else {
      //It's First query request
      requestQuery = collection
        .order(by: "number")
        .limit(to: 5)
    }
    
    requestQuery.addSnapshotListener({ [weak self] (snapshot, error) in
      guard let self = self else { return }
      
      guard let snapshot = snapshot,
            let lastSnapshot = snapshot.documents.last else {
              completion([])
              return
            }
      
      let next = collection
        .order(by: "number")
        .limit(to: 5)
        .start(afterDocument: lastSnapshot)
      
      //Set next query
      self.query = next
      
      let cellModels = snapshot.documents.map({ document -> CellModel in
        do {
          let cellModel = try document.data(as: CellModel.self)
          return cellModel
        } catch {
          return CellModel.empty
        }
      })
      
      DispatchQueue.main.async {
        completion(cellModels)
      }
    })
  }
}
