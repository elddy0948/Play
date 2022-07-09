import Foundation

struct Repo: Decodable {
  let name: String
  let fullName: String
  
  enum CodingKeys: String, CodingKey {
    case name
    case fullName = "full_name"
  }
}
