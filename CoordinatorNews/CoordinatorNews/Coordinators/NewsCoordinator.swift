import UIKit

class NewsCoordinator: Coordinator {
  var children: [Coordinator] = []
  var router: Router
  
  init(router: Router) {
    self.router = router
  }
  
  func present(animated: Bool, onDismissed: (() -> Void)?) {
    let viewController = NewsHomeViewController()
    viewController.delegate = self
    router.present(
      viewController,
      animated: animated,
      onDismissed: onDismissed
    )
  }
}

extension NewsCoordinator: NewsHomeViewControllerDelegate {
  func didSelectNews(_ viewController: UIViewController, news: News) {
    let viewController = NewsDetailViewController(news: news)
    
    router.present(
      viewController,
      animated: true,
      onDismissed: nil
    )
  }
}
