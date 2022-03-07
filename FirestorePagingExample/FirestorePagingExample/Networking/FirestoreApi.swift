import Foundation
import Firebase
import FirebaseFirestoreSwift

final class FirestoreApi {
  
  private let fireStore = Firestore.firestore()
  private var query: Query? = nil
  
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
            let lastDocument = snapshot.documents.last else {
              completion([])
              return
            }
      
      let next = collection
        .order(by: "number")
        .limit(to: 5)
        .start(afterDocument: lastDocument)
      
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
      
      //Paging 을 더 잘보이게 하기 위해 asyncAfter를 사용
      DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
        completion(cellModels)
      })
      
//      DispatchQueue.main.async {
//        completion(cellModels)
//      }
    })
  }
}
