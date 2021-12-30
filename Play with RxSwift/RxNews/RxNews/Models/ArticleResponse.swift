import Foundation

struct ArticleResponse: Decodable {
  let status: String
  let totalResults: Int
  let articles: [Article]
  
  static var empty = ArticleResponse(status: "", totalResults: 0, articles: [])
}
