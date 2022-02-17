import UIKit

class SceneCoordinator: Coordinator {
  var children: [Coordinator] = []
  var router: Router
  
  init(router: Router) {
    self.router = router
  }
  
  func present(animated: Bool,
               onDismissed: (() -> Void)?) {
    let navigationController = UINavigationController()
    let todoListRouter = TodoListRouter(
      navigationController: navigationController
    )
    let todoListCoordinator = TodoListCoordinator(
      router: todoListRouter
    )
    
    router.present(navigationController, animated: animated)
    presentChild(todoListCoordinator, animated: false, onDismissed: nil)
  }
}
