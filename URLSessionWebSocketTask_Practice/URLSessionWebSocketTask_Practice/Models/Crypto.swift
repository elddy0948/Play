import Foundation

struct Crypto: Decodable {
  let symbol: String
  let closePrice: String
  let chgRate: String
  let chgAmt: String
}
