import UIKit

class NewsHomeCoordinator: Coordinator {
  var children: [Coordinator] = []
  var router: Router
  
  init(router: Router) {
    self.router = router
  }
  
  func present(animated: Bool, onDismissed: (() -> Void)?) {
    let viewController = NewsHomeViewController()
    
    router.present(
      viewController,
      animated: animated,
      onDismissed: onDismissed
    )
  }
}
