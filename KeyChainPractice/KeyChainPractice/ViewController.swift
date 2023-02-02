import UIKit
import LocalAuthentication

//Codable 모델을 사용해서 저장하면 된다!!
struct Auth: Codable {
  let uid: String
  let accessToken: String
  let refreshToken: String
  let accessTokenExpired: Int
  let refreshTokenExpired: Int
}

class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    let mockAuth = Auth(
      uid: "5k2p131o2p",
      accessToken: "mock-access-token",
      refreshToken: "mock-refresh-token",
      accessTokenExpired: 100,
      refreshTokenExpired: 100
    )
    
    save(mockAuth)
    var readedAuth = read()
    print(readedAuth)
    delete()
    readedAuth = read()
  }
  
  func save(_ auth: Auth) {
    do {
      try KeychainHelperWithGeneric.standard.save(auth, service: "auth-info", account: "user")
      print("Saved")
    } catch {
      print(error)
    }
  }
  
  func read() -> Auth? {
    do {
      return try KeychainHelperWithGeneric.standard.read(service: "auth-info", account: "user", type: Auth.self)
    } catch {
      print(error)
      return nil
    }
  }
  
  func delete() {
    KeychainHelperWithGeneric.standard.delete(service: "auth-info", account: "user")
  }
}

