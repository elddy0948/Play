import UIKit

class IMessageCollectionViewLayout: UICollectionViewFlowLayout {
  override init() {
    super.init()
    scrollDirection = .horizontal
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
}
