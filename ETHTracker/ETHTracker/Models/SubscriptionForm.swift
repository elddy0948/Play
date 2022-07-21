import Foundation

struct SubscriptionForm: Encodable {
  let type: String
  let symbols: [Symbol]
  let tickTypes: [TickType]
}
