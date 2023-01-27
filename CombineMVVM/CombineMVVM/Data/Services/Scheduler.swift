import Foundation
import Combine

final class Scheduler {
  static var backgroundWorkScheduler: OperationQueue = {
    let operationQueue = OperationQueue()
    operationQueue.maxConcurrentOperationCount = 5
    operationQueue.qualityOfService = .userInitiated
    return operationQueue
  }()
  
  static let mainScheduler = RunLoop.main
}
