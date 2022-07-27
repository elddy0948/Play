import UIKit

final class AppCoordinator: Coordinator {
  var children: [Coordinator] = []
  var router: Router
  
  private let homeNavigationController = UINavigationController()
  private let homeViewController = UIViewController()
  
  init(router: Router) {
    self.router = router
  }
  
  func present(animated: Bool, onDismissed: (() -> Void)?) {
    router.present(homeNavigationController, animated: animated)
    initHomeViewController()
  }
  
  private func initHomeViewController() {
    homeViewController.view.backgroundColor = .systemRed
    homeNavigationController.pushViewController(homeViewController, animated: true)
  }
}
