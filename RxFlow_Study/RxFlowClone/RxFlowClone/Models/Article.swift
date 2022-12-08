import Foundation

struct Article: Decodable {
  let author: String?
  let title: String?
  let description: String?
  let urlToImage: String?
  let content: String?
}
