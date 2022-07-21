import Foundation

class RepositoryTask: Cancelable {
    var networkTask: NetworkCancelable?
    var isCancelled: Bool = false
    
    func cancel() {
        networkTask?.cancel()
        isCancelled = true
    }
}
