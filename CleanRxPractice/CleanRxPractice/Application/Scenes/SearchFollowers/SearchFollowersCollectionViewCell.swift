import UIKit

final class SearchFollowersCollectionViewCell: UICollectionViewCell {
  static let reuseIdentifier = String(describing: SearchFollowersCollectionViewCell.self)
  
  private lazy var loginLabel: UILabel = {
    let label = UILabel()
    label.textColor = .label
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.textAlignment = .center
    label.numberOfLines = 0
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    layout()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  func configureData(_ viewmodel: SearchFollowersItemViewModel) {
    loginLabel.text = viewmodel.login
  }
}

//MARK: - UI Setup / Layout
extension SearchFollowersCollectionViewCell {
  private func layout() {
    contentView.addSubview(loginLabel)
    loginLabel.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      loginLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
      loginLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      loginLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      loginLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
    ])
  }
}
