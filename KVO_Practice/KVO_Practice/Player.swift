import Foundation

@objc
class Player: NSObject, Decodable {
  let name: String
  let number: Int
  let position: String
  
  init(name: String, number: Int, position: String) {
    self.name = name
    self.number = number
    self.position = position
  }
}
