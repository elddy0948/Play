import UIKit

final class InfoView: UIStackView {
  lazy var cryptoNameLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .title3)
    label.textColor = .label
    label.textAlignment = .center
    return label
  }()
  
  lazy var cryptoPriceLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .body)
    label.textColor = .label
    label.textAlignment = .center
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupStackView()
    setupSubViews()
  }
  
  required init(coder: NSCoder) {
    super.init(coder: coder)
    setupStackView()
    setupSubViews()
  }
}

extension InfoView {
  private func setupStackView() {
    axis = .vertical
    distribution = .fill
    backgroundColor = .systemBackground
    spacing = 8
  }
  
  private func setupSubViews() {
    addArrangedSubview(cryptoNameLabel)
    addArrangedSubview(cryptoPriceLabel)
    
    cryptoNameLabel.text = "Crypto name"
    cryptoPriceLabel.text = "0.0$"
  }
}
