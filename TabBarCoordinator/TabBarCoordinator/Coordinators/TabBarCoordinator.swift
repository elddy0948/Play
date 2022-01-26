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
    
    router.present(
      firstNav,
      animated: true
    )
    
    router.present(
      secondNav,
      animated: true
    )
    
    router.present(
      thirdNav,
      animated: true
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
    
    presentChild(
      firstCoordinator,
      animated: true,
      onDismissed: nil
    )
    
    presentChild(
      secondCoordinator,
      animated: true,
      onDismissed: nil
    )
    
    presentChild(
      thirdCoordinator,
      animated: true,
      onDismissed: nil
    )
  }
}
