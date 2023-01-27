import Foundation

struct SRC {
  let original: String?
  let large: String?
  let large2x: String?
  let medium: String?
  let small: String?
  let portrait: String?
  let landscape: String?
  let tiny: String?
}

extension SRC: Decodable {}
