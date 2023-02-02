import UIKit
import LocalAuthentication

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    saveAccessToken()
  }
  
  func saveAccessToken() {
    let accessToken = "dummy-hojoon-access-token"
    let data = Data(accessToken.utf8)
    
    KeychainHelper.standard.save(
      data, service: "access-token", account: "holuck"
    )
  }
}

