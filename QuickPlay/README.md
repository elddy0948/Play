#  QuickPlay

## PhotoKit
PhotoKit이란 Photos 앱에 의해서 관리되는(iClouds Photos, Live Photos 포함) 이미지나 비디오 asset들을 다루는 Kit이다.

iOS와 macOS에서의 PhotoKit은 Photos앱에서 Photo-editing 관련 기능을 지원해주는 클래스들을 지원하고, iOS와 macOS 그리고 tvOS에서 PhotoKit은 또한 Photos앱에 의해 관리되고 있는 사진이나 비디오 asset들에 대한 직접적인 접근권한을 제공한다.

PhotoKit을 사용하여 display와 playback을 위한 asset들을 fetch 혹은 cache 할 수 있고, 이미지나 비디오 콘텐츠를 edit하거나 asset들의 collection들 (albums, moments, shared albums)을 관리할 수 있다.

## PHPickerViewController
Photo Library에서 asset들을 선택할 수 있는 UI를 제공하는 view controller이다.
```swift
class PHPickerViewController: UIViewController
```
### Framework
* PhotosUI

PHPickerViewController 클래스는 `UIImagePickerViewController`를 대체하는 클래스이다. 
`PHPickerViewController`는 안정성과 신뢰성을 향상시켰고, 다음과 같은 유저들과 개발자들에게 몇가지 이점을 제공한다.
* 지연된 이미지 로딩 및 복구 UI
* RAW와 panoramic 이미지들과 같이 크고 복잡한 asset들에 대한 신뢰도 핸들링
* `UIImagePickerViewController`에서 불가능하던 User-selectable asset들이 `PHPickerViewController`에서는 가능
* Live Photo들만 보여주게 configuration 설정 가능
* 라이브러리에 접근하지 않고도 `PHLivePhoto`객체를 사용 가능
* 잘못된 인풋들에 대한 엄격한 유효성 검사

## PHPickerConfiguration
```swift
struct PHPickerConfiguration
```
picker view controller를 어떻게 설정할지에 대한 정보가 포함된 객체이다.

## Setup PHPickerViewController 
```swift
  func setupPHPickerViewController() {
    let configuration = setupConfiguration()
    let viewController = createPHPickerViewController(
      with: configuration
    )
    
    present(
      viewController,
      animated: true,
      completion: nil
    )
  }
  private func setupConfiguration() -> PHPickerConfiguration {
    var configuration = PHPickerConfiguration()
    configuration.selectionLimit = 0
    return configuration
  }
  
  private func createPHPickerViewController(
    with configuration: PHPickerConfiguration
  ) -> PHPickerViewController {
    videos.removeAll()
    let pickerViewController = PHPickerViewController(
      configuration: configuration
    )
    pickerViewController.delegate = self
    return pickerViewController
  }
```

## PHPickerViewControllerDelegate

## PHPickerResult

