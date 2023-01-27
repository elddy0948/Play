import Foundation

struct Resource<T: Decodable> {
  let url: URL
  let parameters: [String : CustomStringConvertible]
  var request: URLRequest? {
    guard var components = URLComponents(
      url: url, resolvingAgainstBaseURL: false) else {
      return nil
    }
    
    components.queryItems = parameters.keys.map({ key in
      URLQueryItem(
        name: key, value: parameters[key]?.description)
    })
    
    guard let url = components.url else { return nil }
    var request = URLRequest(url: url)
    request.addValue(
      APIConstants.apiKey,
      forHTTPHeaderField: "Authorization")
    return request
  }
  
  init(
    url: URL,
    parameters: [String : CustomStringConvertible] = [:]
  ) {
    self.url = url
    self.parameters = parameters
  }
}
