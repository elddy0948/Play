import UIKit

class ProfileLabel: UILabel {
  init(font: UIFont, tintColor: UIColor) {
    super.init(frame: .zero)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  private func setupLabel(
    font: UIFont,
    tintColor: UIColor
  ) {
    self.font = font
    self.tintColor = tintColor
    self.textAlignment = .center
  }
}
