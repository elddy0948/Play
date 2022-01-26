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
      firstVC.delegate = self
      firstVC.title = "First"
      router.present(
        firstVC,
        animated: true
      )
  }
}

extension FirstCoordinator: FirstViewControllerDelegate {
  func didTappedButton(_ viewController: UIViewController) {
    let viewController = PurpleViewController()
    router.present(viewController,
                   animated: true,
                   onDismissed: nil)
  }
}
