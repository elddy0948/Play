import Foundation
import Moya

enum Github {
  case fetchRepos(username: String)
}

extension Github: TargetType {
  var baseURL: URL {
    let stringURL = "https://api.github.com"
    return URL(string: stringURL)!
  }
  
  var path: String {
    switch self {
    case .fetchRepos(let username):
      return "/users/\(username)/repos"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .fetchRepos(_):
      return .get
    }
  }
  
  var task: Task {
    return .requestPlain
  }
  
  var headers: [String : String]? {
    return ["Content-Type": "application/json"]
  }
}
