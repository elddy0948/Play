import UIKit

class ViewController: UIViewController {
  let storageProvider: StorageProvider
  
  init(storageProvider: StorageProvider) {
    self.storageProvider = storageProvider
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemRed
  }
}

