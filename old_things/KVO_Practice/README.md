#  Key Value Observing

### Key-Value Observing?
- KVO는 Cocoa Programming 패턴으로 어떠한 객체의 프로퍼티가 변화하는 것을 다른 객체에 알려주기 위해 사용합니다.
- Property observer와 거의 유사한 기능을 한다고 볼 수 있습니다.


### KVO vs Property observer
- Property observer는 해당 프로퍼티를 정의한 곳에서 옵저버를 둡니다.
```swift
class A {
  var name: String {
    willSet {
      //Do something...
    }
    didSet {
      //Do something...
    }
  }
}
```
- 하지만 KVO는 정의한 곳 밖에서도 옵저버를 두어 프로퍼티를 관찰할 수 있습니다.
```swift
//A.swift
@objc class A: NSObject {
  @objc dynamic var name: String = "Joons"
}

//B.swift
class B {
  let joons = Person()
  joons.observe(\Person.name, options: [.new]) { person, change in 
    //Do something...
  }
}
```

### KVO의 특징
- KVO는 Objective-C 런타임에 의존하고 있습니다. 그렇기에 ```@objc```키워드를 사용해야 하며, 이는 즉 ```NSObject```를 상속받는 Class의 형식으로만 선언할 수 있습니다.
- 또한 관찰하려는 프로퍼티 앞에 ```@objc dynamic``` 키워드를 붙여주어야 합니다. 


### 프로젝트

Player --- PlayerService --- ViewController

```swift
//Player.swift
@objc
class Player: NSObject, Decodable {
  let name: String
  let number: Int
  let position: String
  
  init(name: String, number: Int, position: String) {
    self.name = name
    self.number = number
    self.position = position
  }
}
```
```swift
//PlayerService.swift
@objc
class PlayerService: NSObject {
  @objc dynamic var lineup: [Player] = []
  
  func fetchLineup() { ... }
}
```

```swift
//ViewController.swift
class ViewController: UITableViewController {
  
  var observableLineup: Any?
  var playerService = PlayerService()
  var lineup: [Player] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
    observableLineup = playerService.observe(\PlayerService.lineup,
                                             options: [.initial, .new]) { [weak self] playerService, change in
      guard let self = self else { return }
      self.lineup = playerService.lineup
      self.tableView.reloadData()
    }
  }
  //...
```
![Simulator Screen Shot - iPhone 11 - 2021-10-25 at 14 07 49](https://user-images.githubusercontent.com/40102795/138637506-d5646d10-418d-4565-9ed3-84fa02e16329.png)
