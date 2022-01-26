import UIKit

class FirstCoordinator: Coordinator {
  var children: [Coordinator] = []
  var router: Router
  
  init(router: Router) {
    self.router = router
  }
  
  func present(
    animated: Bool,
    onDismissed: (() -> Void)?) {
      let firstVC = FirstViewController()
      router.present(
        firstVC,
        animated: true
      )
  }
}
