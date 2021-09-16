import Foundation

struct Coin: Decodable {
  let id: String
  let symbol: String
  let name: String
  let image: ImageSize
  
  static let empty = Coin(id: "?", symbol: "", name: "", image: ImageSize(thumb: "", small: "", large: ""))
}

struct ImageSize: Decodable {
  let thumb: String
  let small: String
  let large: String
}
