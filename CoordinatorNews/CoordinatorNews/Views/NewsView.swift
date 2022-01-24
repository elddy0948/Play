import UIKit

class NewsView: UIStackView {
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(
      forTextStyle: .title2
    )
    label.text = "Title"
    label.textColor = .label
    label.numberOfLines = 0
    return label
  }()
  
  private lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.text = "Description"
    label.textColor = .label
    label.numberOfLines = 0
    return label
  }()
  
  private lazy var authorLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(forTextStyle: .caption1)
    label.text = "Author"
    label.textColor = .label
    label.numberOfLines = 0
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
  
  func configureNewsView(_ news: News) {
    titleLabel.text = news.title
    descriptionLabel.text = news.description
    authorLabel.text = news.author
  }
}

//MARK: - UI Setup / Layout
extension NewsView {
  private func setupStackView() {
    axis = .vertical
    spacing = 8
    distribution = .fill
  }
  
  private func setupSubViews() {
    addArrangedSubview(titleLabel)
    addArrangedSubview(descriptionLabel)
    addArrangedSubview(authorLabel)
  }
}
