import Foundation

struct SearchResponse: Decodable {
  let items: [Repo]
}
