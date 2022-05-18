import UIKit

final class PostTableViewCell: UITableViewCell {
  static let reuseIdentifier = String(describing: PostTableViewCell.self)
  
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .title2)
    label.textColor = .label
    label.numberOfLines = 0
    return label
  }()
  
  private lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .body)
    label.textColor = .label
    label.numberOfLines = 0
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    layout()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    layout()
  }
  
  func configure(post: Post) {
    self.titleLabel.text = "Here is Title!"
    self.descriptionLabel.text = "Here is Body!Here is Body!Here is Body!Here is Body!Here is Body!Here is Body!"
  }
}

//MARK: - Setup UI / Layout
extension PostTableViewCell {
  private func layout() {
    let padding: CGFloat = 8
    contentView.addSubview(titleLabel)
    contentView.addSubview(descriptionLabel)
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    
    titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    descriptionLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
      descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
      descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
      descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
    ])
  }
}
