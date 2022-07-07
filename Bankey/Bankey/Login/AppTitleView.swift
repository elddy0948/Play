import UIKit

class AppTitleView: UIView {
  
  let titleLabel = UILabel()
  let subTitleLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    style()
    layout()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
}

extension AppTitleView {
  private func style() {
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.textColor = .label
    titleLabel.font = .preferredFont(
      forTextStyle: .title1, compatibleWith: nil
    )
    titleLabel.text = "Bankey"
    titleLabel.textAlignment = .center
    
    subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    subTitleLabel.textColor = .label
    subTitleLabel.font = .preferredFont(
      forTextStyle: .caption1, compatibleWith: nil
    )
    subTitleLabel.text = "Your premium source for all things banking!"
    subTitleLabel.textAlignment = .center
    subTitleLabel.numberOfLines = 0
  }
  
  private func layout() {
    addSubview(titleLabel)
    addSubview(subTitleLabel)
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: topAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      subTitleLabel.topAnchor.constraint(
        equalToSystemSpacingBelow: titleLabel.bottomAnchor,
        multiplier: 1
      ),
      subTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      subTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      subTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}
