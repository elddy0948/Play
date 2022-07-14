import RxFlow
import UIKit

final class AppFlow: Flow {
  private let window: UIWindow
  
  var root: Presentable {
    return self.window
  }
  
  init(window: UIWindow) {
    self.window = window
  }
  
  func navigate(to step: Step) -> FlowContributors {
    guard let step = step as? ExampleStep else { return .none }
    switch step {
    case .launchIsRequired:
      <#code#>
    case .homeIsRequired:
      <#code#>
    }
  }
}
