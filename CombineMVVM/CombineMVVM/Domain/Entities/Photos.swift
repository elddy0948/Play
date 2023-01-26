import Foundation

struct Photos {
  let photos: [Photo]
  let page: Int
  let perPage: Int
  let totalResults: Int
  let prevPage: Int?
  let nextPage: Int?
}

extension Photos: Decodable {
  enum CodingKeys: String, CodingKey {
    case photos, page
    case perPage = "per_page"
    case totalResults = "total_results"
    case prevPage = "prev_page"
    case nextPage = "next_page"
  }
}
