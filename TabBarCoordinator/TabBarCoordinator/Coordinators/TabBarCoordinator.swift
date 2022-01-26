import UIKit

class TabBarCoordinator: Coordinator {
  var children: [Coordinator] = []
  var router: Router
  
  init(router: Router) {
    self.router = router
  }
  
  func present(animated: Bool, onDismissed: (() -> Void)?) {
    let firstNav = UINavigationController()
    let secondNav = UINavigationController()
    let thirdNav = UINavigationController()
    
    guard let router = router as? TabBarRouter else {
      return
    }
    
    router.present(
      [firstNav, secondNav, thirdNav],
      animated: true,
      onDismissed: nil
    )
    
    let firstRouter = NavigationRouter(
      navigationController: firstNav
    )
    
    let secondRouter = NavigationRouter(
      navigationController: secondNav
    )
    
    let thirdRouter = NavigationRouter(
      navigationController: thirdNav
    )
    
    let firstCoordinator = FirstCoordinator(
      router: firstRouter
    )
    
    let secondCoordinator = SecondCoordinator(
      router: secondRouter
    )

    let thirdCoordinator = ThirdCoordinator(
      router: thirdRouter
    )
    
    presentChildren(
      [firstCoordinator, secondCoordinator, thirdCoordinator],
      animated: true,
      onDismissed: nil
    )
  }
  
  private func presentChildren(
    _ children: [Coordinator],
    animated: Bool,
    onDismissed: (() -> Void)?
  ) {
    children.forEach({ child in
      presentChild(
        child,
        animated: true,
        onDismissed: nil
      )
    })
  }
}
