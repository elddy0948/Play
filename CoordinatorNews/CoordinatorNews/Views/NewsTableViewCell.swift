import UIKit

class NewsTableViewCell: UITableViewCell {
  //MARK: - Type properties
  static let reuseIdentifier = String(
    describing: NewsTableViewCell.self
  )
  
  //MARK: - Views
  private lazy var newsView = NewsView(frame: .zero)
  
  //MARK: - Initializer
  override init(
    style: UITableViewCell.CellStyle,
    reuseIdentifier: String?
  ) {
    super.init(
      style: style,
      reuseIdentifier: reuseIdentifier
    )
    setupNewsView()
    layout()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupNewsView()
    layout()
  }
  
  func configureNews(_ news: News) {
    newsView.configureNewsView(news)
  }
}

//MARK: - UI Setup / Layout
extension NewsTableViewCell {
  private func setupNewsView() {
    contentView.addSubview(newsView)
    newsView.translatesAutoresizingMaskIntoConstraints = false
  }
  
  private func layout() {
    let padding: CGFloat = 8
    NSLayoutConstraint.activate([
      newsView.topAnchor.constraint(
        equalTo: contentView.topAnchor,
        constant: padding
      ),
      newsView.leadingAnchor.constraint(
        equalTo: contentView.leadingAnchor,
        constant: padding
      ),
      newsView.trailingAnchor.constraint(
        equalTo: contentView.trailingAnchor,
        constant: -padding
      ),
      newsView.bottomAnchor.constraint(
        equalTo: contentView.bottomAnchor,
        constant: -padding
      ),
    ])
  }
}
