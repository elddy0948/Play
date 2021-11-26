import Foundation

struct ArticleResponse: Decodable {
  let status: String
  let totalResults: Int
  let articles: [Article]
}
