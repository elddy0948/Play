import Foundation

struct ETHResponse: Decodable {
  let type: String
  let content: Ticker
}
