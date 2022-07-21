import Foundation

enum TickType: String, Codable {
  case oneHour = "1H"
  case halfHour = "30M"
  case twelveHours = "12H"
  case oneDay = "24H"
  case mid = "MID"
}
