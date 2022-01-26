import UIKit

class SceneCoordinator: Coordinator {
  var children: [Coordinator] = []
  var router: Router
  
  init(router: Router) {
    self.router = router
  }
  
  func present(
    animated: Bool,
    onDismissed: (() -> Void)?) {
      let tabBarController = UITabBarController()
      
      self.router.present(
        tabBarController,
        animated: true
      )
      
      let router = TabBarRouter(
        tabBarController: tabBarController
      )
      
      let coordinator = TabBarCoordinator(
        router: router
      )
      
      presentChild(
        coordinator,
        animated: true,
        onDismissed: nil
      )
      
    }
}
