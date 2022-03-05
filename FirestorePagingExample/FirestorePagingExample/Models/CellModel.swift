import Foundation

struct CellModel: Decodable {
  let number: Int
  let greeting: String
}

extension CellModel {
  static var empty: CellModel {
    return CellModel(number: -1, greeting: "I Don't know who i am")
  }
}
