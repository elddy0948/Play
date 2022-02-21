import Foundation

enum Priority: Int {
  case high
  case medium
  case low
}

struct Item {
  let content: String
  let priority: Priority
}
