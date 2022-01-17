import Foundation

struct SubscriptionType: Encodable {
  let type: String
  let symbols: [String]
  let tickTypes: [String]?
}
