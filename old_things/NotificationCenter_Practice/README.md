#  Notification Center 

## (TODO) Notification에 대한 설명 작성하기.


## 프로젝트 코드

1. 우선 Notification Center를 정의해줍니다. 
```swift
extension Notification.Name {
static let DidFetchBestClub = Notification.Name("DidFetchBestClub")
}
```
2. 이후 해당 Notification Center에 대한 Observer를 ViewController에서 정의해줍니다. 
```swift
NotificationCenter.default.addObserver(self,
                                       selector: #selector(performDidFetchBestClub(_:)),
                                       name: .DidFetchBestClub,
                                       object: nil)
```
NotificationCenter에서 post가 발생하면 해당 Observer를 추가한 ```self```에서 selector인 ```performDidFetchBestClub``` 메서드가 실행될 것 입니다. 

3. post를 하는 메서드를 만들어보면
```swift
struct ClubService {
  func fetchBestClub() {
    let bestClub = Club(name: "Chelsea", homeGround: "London", homeStadium: "Stanford Bridge")
    let userInfo = ["club": bestClub]
    NotificationCenter.default.post(name: .DidFetchBestClub, object: nil, userInfo: userInfo)
  }
}
```
DidFetchBestClub이라는 Notificationd에 userInfo라는 Dictionary 타입을 같이 post해줍니다.

4. 그럼 해당 Notification을 Observing하고있던 Observer는 selector인 ```performDidFetchBestClub```메서드를 실행시키고
```swift
@objc func performDidFetchBestClub(_ notification: Notification) {
  guard let bestClub = notification.userInfo?["club"] as? Club else {
    return
  }
  clubLabel.text = "\(bestClub.name)\n\(bestClub.homeGround)\n\(bestClub.homeStadium)"
}
```
결과에 따라 clubLabel.text를 바꾸게 될 것입니다.
