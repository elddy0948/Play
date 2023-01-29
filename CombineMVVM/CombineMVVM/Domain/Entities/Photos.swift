import Foundation

struct Photos {
  let photos: [Photo]
  let page: Int
  let perPage: Int
  let totalResults: Int
  let prevPage: String?
  let nextPage: String?
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

extension Photos {
  static func empty() -> Photos {
    return Photos(
      photos: [],
      page: 0,
      perPage: 10,
      totalResults: 0,
      prevPage: nil,
      nextPage: nil
    )
  }
}
