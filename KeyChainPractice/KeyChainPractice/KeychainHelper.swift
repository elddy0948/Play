import Foundation

final class KeychainHelper {
  static let standard = KeychainHelper()
  
  private init() {}
  
  func save(_ data: Data, service: String, account: String) {
    let query = [
      kSecValueData: data,
      kSecClass: kSecClassGenericPassword,
      kSecAttrService: service,
      kSecAttrAccount: account,
    ] as CFDictionary
    
    let status = SecItemAdd(query, nil)
    if status != errSecSuccess {
      print("Error! : \(status)")
    }
  }
}
