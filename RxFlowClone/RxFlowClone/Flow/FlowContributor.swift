import UIKit

enum FlowContributor {
  case contribute(withNextPresentable: Presentable,
                  withNextStepper: Stepper,
                  allowStepWhenNotPresented: Bool = false,
                  allowStepWhenDismissed: Bool = false)
  case forwardToCurrentFlow(withStep: Step)
  case forwardToParentFlow(withStep: Step)
  
  static func contribute(
    withNext nextPresentableAndStepper: Presentable & Stepper
  ) -> FlowContributor {
    return .contribute(
      withNextPresentable: nextPresentableAndStepper,
      withNextStepper: nextPresentableAndStepper
    )
  }
}

enum FlowContributors {
  case multiple(flowContributors: [FlowContributor])
  case one(flowContributor: FlowContributor)
  case end(forwardToParentFlowWithStep: Step)
  case none
}
