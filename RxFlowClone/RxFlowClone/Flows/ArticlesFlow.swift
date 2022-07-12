import UIKit
import RxSwift

class ArticlesFlow: Flow {
  func navigate(to step: Step) -> FlowContributors {
    
  }
  
  var rxVisible: Observable<Bool>
  
  var rxDismissed: Single<Void>
  
  var root: Presentable {
    return self.rootViewController
  }
  
  private var rootViewController = UINavigationController()
}
