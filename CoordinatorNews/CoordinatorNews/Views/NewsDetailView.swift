import UIKit

class NewsDetailView: UIStackView {
  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.textColor = .label
    label.font = UIFont.preferredFont(forTextStyle: .title1)
    label.numberOfLines = 0
    return label
  }()
  
  lazy var authorLabel: UILabel = {
    let label = UILabel()
    label.textColor = .label
    label.textAlignment = .right
    label.font = UIFont.preferredFont(forTextStyle: .caption1)
    label.numberOfLines = 0
    return label
  }()
  
  lazy var contentLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.textColor = .label
    label.numberOfLines = 0
    return label
  }()
  
  init(news: News) {
    super.init(frame: .zero)
    setupStackView()
    setupSubViews(with: news)
  }
  
  required init(coder: NSCoder) {
    super.init(coder: coder)
  }
}

//MARK: - UI Setup / Layout
extension NewsDetailView {
  private func setupStackView() {
    axis = .vertical
    distribution = .equalSpacing
    spacing = 8
    backgroundColor = .systemBackground
  }
  
  private func setupSubViews(with news: News) {
    addArrangedSubview(titleLabel)
    addArrangedSubview(authorLabel)
    addArrangedSubview(contentLabel)
    
    titleLabel.text = news.title
    authorLabel.text = news.author
    contentLabel.text = news.content
  }
}
