import UIKit

class TodoListCoordinator: Coordinator {
  var children: [Coordinator] = []
  var router: Router
  
  init(router: Router) {
    self.router = router
  }
  
  func present(animated: Bool, onDismissed: (() -> Void)?) {
    let todoListViewController = TodoListViewController()
    
    todoListViewController.delegate = self
    
    router.present(
      todoListViewController,
      animated: animated
    )
  }
}

extension TodoListCoordinator: TodoListViewControllerDelegate {
  func didTappedAddButton(_ viewController: TodoListViewController) {
    guard let router = router as? TodoListRouter else { return }
    let addTodoViewController = AddTodoViewController()
    router.presentModally(addTodoViewController, animated: true, onDismissed: nil)
  }
}
