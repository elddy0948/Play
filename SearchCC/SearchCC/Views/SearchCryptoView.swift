import UIKit

class SearchCryptoView: UIView {
  
  private var coinImageView: UIImageView!
  private var coinNameLabel: UILabel!
  
  private let placeholderImage = UIImage(systemName: "questionmark.circle")!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .systemBackground
    
    configureImageView()
    configureCoinNameLabel()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureImageView() {
    coinImageView = UIImageView(image: placeholderImage)
    addSubview(coinImageView)
    
    coinImageView.translatesAutoresizingMaskIntoConstraints = false
    coinImageView.contentMode = .scaleAspectFit
    coinImageView.tintColor = .label
    
    NSLayoutConstraint.activate([
      coinImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
      coinImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
      coinImageView.heightAnchor.constraint(equalToConstant: 100),
      coinImageView.widthAnchor.constraint(equalToConstant: 100),
    ])
  }
  
  private func configureCoinNameLabel() {
    let padding: CGFloat = 8
    
    coinNameLabel = UILabel()
    addSubview(coinNameLabel)
    
    coinNameLabel.translatesAutoresizingMaskIntoConstraints = false
    coinNameLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    coinNameLabel.textColor = .label
    coinNameLabel.textAlignment = .center
    coinNameLabel.text = "Coin Name"
    
    NSLayoutConstraint.activate([
      coinNameLabel.topAnchor.constraint(equalTo: coinImageView.bottomAnchor, constant: padding),
      coinNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
      coinNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
      coinNameLabel.heightAnchor.constraint(equalToConstant: 30)
    ])
  }
  
  func setCryptoViewData(with coin: Coin) {
    coinNameLabel.text = coin.name
  }
}
