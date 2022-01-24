import Foundation

struct News: Decodable {
  let source: Source
  let author: String?
  let title: String?
  let description: String?
  let content: String?
}
