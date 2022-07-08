import UIKit

class ViewController: UIViewController {
  


  override func viewDidLoad() {
    super.viewDidLoad()
    let observable = Observable<Int> { (observer) -> Disposable in
      observer.on(event: .next(1))
      observer.on(event: .next(2))
      observer.on(event: .next(3))
      observer.on(event: .completed)
      return AnonimousDisposable({
        print("disposed")
      })
    }
    
    observable.subscribe(observer: Observer(handler: { (event) in
      print(event)
    }))
    
    observable.map({ element in
      return element * element
    })
    .subscribe(observer: Observer(handler: { event in
      print(event)
    }))
  }
}

