import Foundation

struct Article: Decodable {
  let source: ArticleSource
  let author: String?
  let title: String
  let description: String
  let url: String
  let urlToImage: String
  let publishedAt: String
  let content: String
}

struct ArticleSource: Decodable {
  let id: String?
  let name: String
}
