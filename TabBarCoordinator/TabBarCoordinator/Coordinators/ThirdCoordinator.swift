import UIKit

class ThirdCoordinator: Coordinator {
  var children: [Coordinator] = []
  var router: Router
  
  init(router: Router) {
    self.router = router
  }
  
  func present(
    animated: Bool,
    onDismissed: (() -> Void)?) {
      let thirdVC = ThirdViewController()
      router.present(
        thirdVC,
        animated: true
      )
  }
}
