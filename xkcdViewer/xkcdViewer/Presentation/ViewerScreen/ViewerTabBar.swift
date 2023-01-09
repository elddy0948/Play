import UIKit

final class ViewerTabBar: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .systemBlue
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
