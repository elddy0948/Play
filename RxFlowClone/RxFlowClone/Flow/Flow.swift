import RxSwift
import UIKit

private var subjectContext: UInt8 = 0

protocol Flow: AnyObject, Presentable {
  var root: Presentable { get }
  // Adapts an incoming step before the navigate(to:) function
  func adapt(step: Step) -> Single<Step>
  func navigate(to step: Step) -> FlowContributors
}


