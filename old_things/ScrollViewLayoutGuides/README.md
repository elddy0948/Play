#  ScrollView frameLayoutGuide, contentLayoutGuide


`frameLayoutGuide`를 사용하여 scrollView Layout 구현

```swift
let frameLayoutGuide = scrollView.frameLayoutGuide
    
NSLayoutConstraint.activate([
  frameLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
  frameLayoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
  frameLayoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
  frameLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
])
```

`contentLayoutGuide`를 사용하여 scrollView 내에 들어가는 stackView Layout 구현

```swift
let contentLayoutGuide = scrollView.contentLayoutGuide

NSLayoutConstraint.activate([
  stackView.widthAnchor.constraint(equalTo: view.widthAnchor),
  stackView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
  stackView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
  stackView.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor),
  stackView.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor),
])
```
