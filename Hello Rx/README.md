# Hello, Rx!

### Observable.just()

```swift
static func just(_ element: Int) -> Observable<Int>
```

element : **Single element** in the resulting observable sequence.

```swift
var ofObservable: Observable<Int>

override func viewDidLoad() {
	//...
	justObservable = Observable.just(one)
  //...
}

@IBAction func justAction(_ sender: UIButton) {
  //...
      justObservable
      .subscribe(onNext: { [weak self] number in
        self?.labelText.append("\(number) ")
      },
      onCompleted: { [weak self] in
        DispatchQueue.main.async {
          self?.onCompletedLabel.text = "✅"
        }
      })
      .disposed(by: disposeBag)
}
```

### Observable.of()

```swift
static func of(_ elements: Int..., 
							scheduler: ImmediateSchedulerType = CurrentThreadScheduler.instance) -> Observable<Int>
```

elements : Elements to generate.

scheduler : Scheduler to send elements on. If `nil`, **elements are sent immediately on subscription**.

```swift
var ofObservable: Observable<Int>

override func viewDidLoad() {
  //...
  ofObservable = Observable.of(one, two, three)
}

@IBAction func ofAction(_ sender: UIButton) {
  //...
  ofObservable
  .subscribe(onNext: { [weak self] number in
    self?.labelText.append("\(number)")
  },
  onCompleted: { [weak self] in
    DispatchQueue.main.async {
      self?.onCompletedLabel.text = "✅"
    }
  })
  .disposed(by: disposeBag)
}
```

### Observable.from()

```swift
static func from(_ array: [Int], 
                 scheduler: ImmediateSchedulerType = CurrentThreadScheduler.instance) -> Observable<Int>
```

```swift
var fromObservable: Observable<[Int]>?

override func viewDidLoad() {
  //...
	fromObservable = Observable.from(optional: [one, two, three])
}

@IBAction func fromAction(_ sender: UIButton) {
  //...
  fromObservable
  .subscribe(onNext: { [weak self] number in
    self?.labelText.append("\(number) ")
  },
  onCompleted: { [weak self] in
    DispatchQueue.main.async {
      self?.onCompletedLabel.text = "✅"
    }
  })
  .disposed(by: disposeBag)
}

```

### DisposeBag



## Screen

### Just(1)

<img src="https://user-images.githubusercontent.com/40102795/130323841-ff6c8ae1-f40f-4d26-a285-ca1369a79ba4.png" alt="Simulator Screen Shot - iPhone 12 - 2021-08-21 at 22 48 36" style="zoom: 25%;" />

### of(1, 2, 3)

<img src="https://user-images.githubusercontent.com/40102795/130323843-d0c0e5dc-048d-4052-996b-7113262fe6bd.png" alt="Simulator Screen Shot - iPhone 12 - 2021-08-21 at 22 48 48" style="zoom:25%;" />

### from([1, 2, 3])

<img src="https://user-images.githubusercontent.com/40102795/130323845-fa6575f3-c2df-4af4-b94d-7e959c33c6a6.png" alt="Simulator Screen Shot - iPhone 12 - 2021-08-21 at 22 48 52" style="zoom:25%;" />