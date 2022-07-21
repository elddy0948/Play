#  UIPanGestureRecognizer를 활용하여 View 움직이기

## 프로젝트 코드

1. UIPanGestureRecognizer 정의 ```panGestureRecognizer```의 Selector로 ```handlePanGestureRecognizer```메서드를 추가.
```swift
private func configureGestureRecognizer() {
  panGestureRecognizer = UIPanGestureRecognizer()
  panGestureRecognizer.addTarget(self, action: #selector(handlePanGestureRecognizer(_:)))
}
```
2. View에 UIPanGestureRecognizer 추가
```swift
private func configureView() {
  movableView = UIView()
  view.addSubview(movableView)
  
  movableView.translatesAutoresizingMaskIntoConstraints = false
  movableView.backgroundColor = .systemGreen
  movableView.addGestureRecognizer(panGestureRecognizer) //Gesture Recognizer 추가
}
```

3. 이제 UIPanGestureRecognizer의 ```translation```메서드를 활용하여 recognizer의 변화에 따른 x, y 좌표를 읽어오고, recognizer의 ```state```에 따라서 View의 center를 변화시켜준다.
```swift
@objc func handlePanGestureRecognizer(_ recognizer: UIPanGestureRecognizer) {
  guard let movableView = recognizer.view else { return }
  
  let translation = recognizer.translation(in: movableView.superview)
  
  switch recognizer.state {
  case .began:
    self.centerWhenBegan = movableView.center
  case .changed:
    let newCenter = CGPoint(x: centerWhenBegan.x + translation.x, y: centerWhenBegan.y + translation.y)
    movableView.center = newCenter //Move View!!
  case .ended:
    print("Ended!")
  default:
    print("Default!")
  }
}
```
![Simulator Screen Recording - iPhone 11 - 2021-10-26 at 12 37 02](https://user-images.githubusercontent.com/40102795/138804843-0ef23ac4-2d60-4d67-9aed-cee723d127e1.gif)
