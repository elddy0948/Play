import Foundation

struct NewsResponse: Decodable {
  let status: String
  let totalResults: Int
  let articles: [News]
}
