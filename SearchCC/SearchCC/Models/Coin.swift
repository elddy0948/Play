import Foundation

struct Coin: Decodable {
  let id: String
  let symbol: String
  let name: String
  let image: ImageSize
}

struct ImageSize: Decodable {
  let thumb: String
  let small: String
  let large: String
}
