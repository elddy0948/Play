import UIKit
import RxCocoa
import RxSwift

class AppFlow: Flow {
  
  var window: UIWindow
  
  var root: Presentable {
    return self.window
  }
  
  init(window: UIWindow) {
    self.window = window
  }
  
  func navigate(to step: Step) -> FlowContributors {
    guard let step = step as? DemoStep else { return .none }
    
    switch step {
    case .splash:
      return navigationToSplashScreen()
    case .home:
      return navigationToHomeScreen()
    default:
      return .none
    }
  }
  
  private func navigationToSplashScreen() -> FlowContributors {
    
  }
  
  private func navigationToHomeScreen() -> FlowContributors {
    
  }
}
