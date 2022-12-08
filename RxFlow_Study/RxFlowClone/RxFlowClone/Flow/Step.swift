import Foundation

public protocol Step {}

struct NoneStep: Step, Equatable {}

public enum RxFlowStep: Step {
  case home
}
