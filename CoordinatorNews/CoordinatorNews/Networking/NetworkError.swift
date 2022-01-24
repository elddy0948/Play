enum NetworkError: Error {
  case invalidRequest
  case invalidData
  
  var message: String {
    switch self {
    case .invalidRequest:
      return "Invalid Request!"
    case .invalidData:
      return "Invalid Data!"
    }
  }
}
