import UIKit

class SecondCoordinator: Coordinator {
  var children: [Coordinator] = []
  var router: Router
  
  init(router: Router) {
    self.router = router
  }
  
  func present(
    animated: Bool,
    onDismissed: (() -> Void)?) {
      let secondVC = SecondViewController()
      router.present(
        secondVC,
        animated: true
      )
  }
}
