import UIKit

class ProfileImageView: UIImageView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureImageView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setupBorderShape()
  }
  
  private func configureImageView() {
    backgroundColor = .systemGray
    contentMode = .scaleAspectFit
    clipsToBounds = true
  }
  
  private func setupBorderShape() {
    let width = self.bounds.size.width
    layer.cornerRadius = width / 2
  }
}
