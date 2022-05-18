import UIKit

final class PostsViewController: UIViewController {
  private let coreDataUseCaseProvider: UseCaseProvider
  
  init() {
    coreDataUseCaseProvider = CDUseCaseProvider()
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    coreDataUseCaseProvider = CDUseCaseProvider()
    super.init(coder: coder)
  }
}
