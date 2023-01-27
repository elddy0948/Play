import Foundation

extension Resource {
  static func curatedPhotos(
    page: Int, perPage: Int
  ) -> Resource<Photos> {
    let url = APIConstants.baseURL
    let parameters: [String : CustomStringConvertible] = [
      "page" : "\(page)",
      "per_page" : "\(perPage)"
    ]
    return Resource<Photos>(
      url: url, parameters: parameters)
  }
}
