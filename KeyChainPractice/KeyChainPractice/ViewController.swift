import UIKit
import LocalAuthentication

//Codable 모델을 사용해서 저장하면 된다!!

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  func saveAccessToken() {
    let accessToken = "dummy-hojoon-access-token"
    let data = Data(accessToken.utf8)
    
    KeychainHelper.standard.save(
      data, service: "access-token", account: "holuck"
    )
  }
  
  func readAccessToken() {
    let data = KeychainHelper.standard.read(service: "access-token", account: "holuck")!
    let accessToken = String(data: data, encoding: .utf8) ?? "no data"
    print(accessToken)
  }
}

