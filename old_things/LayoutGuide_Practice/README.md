#  Layout Guide

## UILayoutGuide

Configure UILayoutGuide for RedView and BlueView
```swift
let redContainer = UILayoutGuide()
let blueContainer = UILayoutGuide()
```

`addLayoutGuide()` for redContainer and blueContainer
```swift
view.addLayoutGuide(redContainer)
redView.addLayoutGuide(blueContainer)
```

Configure RedView and BlueView
```swift
view.addSubview(redView)
redView.addSubview(blueView)

redView.translatesAutoresizingMaskIntoConstraints = false
blueView.translatesAutoresizingMaskIntoConstraints = false

NSLayoutConstraint.activate([
  //Red View
  redView.topAnchor.constraint(equalTo: redContainer.topAnchor),
  redView.leadingAnchor.constraint(equalTo: redContainer.leadingAnchor),
  redView.trailingAnchor.constraint(equalTo: redContainer.trailingAnchor),
  redView.bottomAnchor.constraint(equalTo: redContainer.bottomAnchor),
  
  //Blue View
  blueView.topAnchor.constraint(equalTo: blueContainer.topAnchor),
  blueView.leadingAnchor.constraint(equalTo: blueContainer.leadingAnchor),
  blueView.trailingAnchor.constraint(equalTo: blueContainer.trailingAnchor),
  blueView.bottomAnchor.constraint(equalTo: blueContainer.bottomAnchor),
])
```

Setup each LayoutGuides at `view.safeAreaLayoutGuide` and `redView.layoutMarginsGuide`

```swift
let safeAreaLayoutGuide = view.safeAreaLayoutGuide

NSLayoutConstraint.activate([
  //Container
  redContainer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,
                                constant: 20),
  redContainer.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                                    constant: 50),
  redContainer.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                                     constant: -50),
  redContainer.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                   constant: -20),
])

let margins = redView.layoutMarginsGuide

NSLayoutConstraint.activate([
  blueContainer.topAnchor.constraint(equalTo: margins.topAnchor),
  blueContainer.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
  blueContainer.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
  blueContainer.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
])
```

## Screen
<image src="screenshot.png" width="250">
