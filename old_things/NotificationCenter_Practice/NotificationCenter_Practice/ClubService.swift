import Foundation

struct ClubService {
  func fetchBestClub() {
    let bestClub = Club(name: "Chelsea", homeGround: "London", homeStadium: "Stanford Bridge")
    let userInfo = ["club": bestClub]
    NotificationCenter.default.post(name: .DidFetchBestClub, object: nil, userInfo: userInfo)
  }
}
