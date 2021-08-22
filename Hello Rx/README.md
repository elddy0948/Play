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

### Observable.empty()

```swift
static func empty() -> Observable<()>
```

```swift
var emptyObservable: Observable<Void>?

override func viewDidLoad() {
	//...
	emptyObservable = Observable.empty()
  //...
}
@IBAction func emptyAction(_ sender: UIButton) {
  //...
	emptyObservable
	  .subscribe(onCompleted: { [weak self] in
	    DispatchQueue.main.async {
	      self?.onCompletedLabel.text = "onCompleted: ✅"
	    }
	  })
	  .disposed(by: disposeBag)
}
```



### Observable.never()

```swift
static func never() -> Observable<()>
```

```swift
var neverObservable: Observable<Void>?

override func viewDidLoad() {
	//...
	neverObservable = Observable.never()
	//...
}

@IBAction func neverAction(_ sender: UIButton) {
  //...
	neverObservable
	.subscribe(onCompleted: { [weak self] in
	  DispatchQueue.main.async {
	    self?.onCompletedLabel.text = "onCompleted: ✅"
	  }
	})
	.disposed(by: disposeBag)
}
```



### Observable.range()

```swift
static func range(start: Int, 
									count: Int, 
									scheduler: ImmediateSchedulerType = CurrentThreadScheduler.instance) -> Observable<Int>
```

```swift
var rangeObservable: Observable<Int>?

override func viewDidLoad() {
	//...
	rangeObservable = Observable.range(start: 1, count: 10)
}

@IBAction func rangeOneToTenAction(_ sender: UIButton) {
  //...
	rangeObservable
	.subscribe(onNext: { [weak self] number in
	  self?.labelText.append("\(number)")
	},
	onCompleted: { [weak self] in
	  DispatchQueue.main.async {
	    self?.onCompletedLabel.text = "onCompleted: ✅"
	  }
	})
	.disposed(by: disposeBag)
}
```



## Screen

### Just(1) / of(1, 2, 3) / from([1, 2, 3])

<img src="https://user-images.githubusercontent.com/40102795/130323841-ff6c8ae1-f40f-4d26-a285-ca1369a79ba4.png" alt="Simulator Screen Shot - iPhone 12 - 2021-08-21 at 22 48 36" width="200" height="400" /><img src="https://user-images.githubusercontent.com/40102795/130323843-d0c0e5dc-048d-4052-996b-7113262fe6bd.png" alt="Simulator Screen Shot - iPhone 12 - 2021-08-21 at 22 48 48" width="200" height="400" /><img src="https://user-images.githubusercontent.com/40102795/130323845-fa6575f3-c2df-4af4-b94d-7e959c33c6a6.png" alt="Simulator Screen Shot - iPhone 12 - 2021-08-21 at 22 48 52" width="200" height="400" />

### Empty() / Never() / Range(1~10)

<img src="https://user-images.githubusercontent.com/40102795/130326894-c5ec96cf-8213-4f11-a2f2-e9cf1a08db60.png" alt="Simulator Screen Shot - iPhone 12 - 2021-08-22 at 00 29 24" width="200" height="400" /><img src="https://user-images.githubusercontent.com/40102795/130326896-7b638b83-59c7-4c2a-b2e8-ca3660160a70.png" alt="Simulator Screen Shot - iPhone 12 - 2021-08-22 at 00 29 29" width="200" height="400" /><img src="https://user-images.githubusercontent.com/40102795/130326900-640f91df-4093-4305-abf6-f4daa20f7ccf.png" alt="Simulator Screen Shot - iPhone 12 - 2021-08-22 at 00 29 34" width="200" height="400" />

