import UIKit

final class ViewerToolBar: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .systemRed
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
