import Combine
import Foundation
import UIKit.UIImage

struct PhotoCellViewModel {
  let id: Int
  let width: Int
  let height: Int
  let url: String
  let photographer: String
  let photographerURL: String
  let photographerID: Int
  let avgColor: String
  let image: AnyPublisher<UIImage?, Never>
  let alt: String
}

extension PhotoCellViewModel: Hashable {
  static func == (lhs: PhotoCellViewModel, rhs: PhotoCellViewModel) -> Bool {
    return lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
    return hasher.combine(id)
  }
}
