import UIKit

protocol Router: AnyObject {
  func present(
    _ viewController: UIViewController,
    animated: Bool,
    onDismissed: (() -> Void)?
  )
  
  func present(
    _ viewController: UIViewController,
    animated: Bool
  )
  
  func dismiss(animated: Bool)
}

//MARK: - Protocol Extension
extension Router {
  public func present(
    _ viewController: UIViewController,
    animated: Bool
  ) {
    present(
      viewController,
      animated: animated,
      onDismissed: nil
    )
  }
}
