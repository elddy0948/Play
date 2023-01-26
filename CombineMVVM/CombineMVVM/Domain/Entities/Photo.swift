import Foundation

struct Photo {
  let id: Int
  let width: Int
  let height: Int
  let url: String
  let photographer: String
  let photographerURL: String
  let photographerID: Int
  let avgColor: String
  let src: SRC
  let alt: String
}

extension Photo: Hashable {
  static func == (lhs: Photo, rhs: Photo) -> Bool {
    return lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

extension Photo: Decodable {
  enum CodingKeys: String, CodingKey {
    case id, width, height, url, photographer
    case photographerURL = "photographer_url"
    case photographerID = "photographer_id"
    case avgColor = "avg_color"
    case src, alt
  }
}
