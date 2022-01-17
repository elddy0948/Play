import Foundation

struct TickerResponse: Decodable {
  let type: String
  let content: Crypto
}
