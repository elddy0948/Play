import Foundation

struct User {
  let email: String
  let password: String
}

extension User {
  static var empty: User {
    return User(email: "", password: "")
  }
}
