import Foundation

enum KeychainError: Error {
  case failedToEncoding
  case failedToSave
  case failedToRead
  case failedToDecoding
}

final class KeychainHelperWithGeneric {
  static let standard = KeychainHelperWithGeneric()
  
  private init() {}
  
  func save<T: Codable>(_ item: T, service: String, account: String) throws {
    do {
      let data = try JSONEncoder().encode(item)
      try save(data, service: service, account: account)
    } catch {
      throw KeychainError.failedToEncoding
    }
  }
  
  func read<T: Codable>(service: String, account: String, type: T.Type) throws -> T? {
    guard let data = read(service: service, account: account) else {
      throw KeychainError.failedToRead
    }
    
    do {
      let item = try JSONDecoder().decode(type, from: data)
      return item
    } catch {
      throw KeychainError.failedToDecoding
    }
  }
  
  func delete(service: String, account: String) {
    let query = [
      kSecAttrService: service,
      kSecAttrAccount: account,
      kSecClass: kSecClassGenericPassword
    ] as CFDictionary
    
    SecItemDelete(query)
  }
  
  private func read(service: String, account: String) -> Data? {
    let query = [
      kSecAttrService: service,
      kSecAttrAccount: account,
      kSecClass: kSecClassGenericPassword,
      kSecReturnData: true
    ] as CFDictionary
    
    var result: AnyObject?
    SecItemCopyMatching(query, &result)
    
    return (result as? Data)
  }
  
  private func save(_ data: Data, service: String, account: String) throws {
    let query = [
      kSecValueData: data,
      kSecClass: kSecClassGenericPassword,
      kSecAttrService: service,
      kSecAttrAccount: account,
    ] as CFDictionary
    
    let status = SecItemAdd(query, nil)
    
    if status != errSecSuccess {
      throw KeychainError.failedToSave
    }
    
    if status == errSecDuplicateItem {
      let query = [
        kSecAttrService: service,
        kSecAttrAccount: account,
        kSecClass: kSecClassGenericPassword
      ] as CFDictionary
      
      let attributesToUpdate = [kSecValueData: data] as CFDictionary
      
      //update
      SecItemUpdate(query, attributesToUpdate)
    }
  }
}
