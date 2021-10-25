import Foundation

@objc
class PlayerService: NSObject {
  @objc dynamic var lineup: [Player] = []
  
  func fetchLineup() {
    guard let bundleURL = Bundle.main.url(forResource: "Lineup",
                                          withExtension: "json") else { return }
    do {
      let data = try Data(contentsOf: bundleURL)
      let lineup = try JSONDecoder().decode([Player].self,
                                        from: data)
      self.lineup = lineup
    } catch {
      print(error)
      return 
    }
  }
}
