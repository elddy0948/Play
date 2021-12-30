# Relay

### *화면에서는 onNext라고 적혀있지만.. accept입니다..(실수실수)

![Simulator Screen Recording - iPhone SE (2nd generation) - 2021-08-24 at 14 31 56](https://user-images.githubusercontent.com/40102795/130561272-4313f871-5f36-4e12-88ea-72223a7fbf6e.gif)

### Publish Relay

Relay에서는 기본적으로 onNext(_:)가 아닌 accept( _:)를 사용합니다. (onError 나 onCompleted도 추가하지 못합니다.)

accept의 동작은 Publish Subject의 onNext의 동작과 유사합니다.



![Simulator Screen Recording - iPhone SE (2nd generation) - 2021-08-24 at 14 32 11](https://user-images.githubusercontent.com/40102795/130561278-45cbbec4-0f13-4b7d-b583-195e00d13b9b.gif)

### Behavior Relay

Behavior Relay는 Behavior Subject와 비슷합니다. 

Current Value를 확인할 수 있는 기능이 있습니다.