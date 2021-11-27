import UIKit

class ArticleTableViewCell: UITableViewCell {
  static let reuseIdentifier = String(describing: ArticleTableViewCell.self)
  
  private lazy var articleCellStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  private lazy var titleLabel: ArticleLabel = {
    let articleLabel = ArticleLabel(textStyle: .title1)
    articleLabel.text = "Title"
    return articleLabel
  }()
  
  private lazy var descriptionLabel: ArticleLabel = {
    let articleLabel = ArticleLabel(textStyle: .body)
    articleLabel.text = "Description"
    return articleLabel
  }()
  
  private lazy var authorLabel: ArticleLabel = {
    let articleLabel = ArticleLabel(textStyle: .footnote)
    articleLabel.text = "Author"
    return articleLabel
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupLayoutUI()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupLayoutUI()
  }
  
  func setupCellData(with article: Article) {
    titleLabel.text = article.title
    descriptionLabel.text = article.description
    authorLabel.text = article.author
  }
  
  private func setupLayoutUI() {
    contentView.addSubview(articleCellStackView)
    articleCellStackView.addArrangedSubview(titleLabel)
    articleCellStackView.addArrangedSubview(descriptionLabel)
    articleCellStackView.addArrangedSubview(authorLabel)
    
    let layoutGuide = contentView.readableContentGuide
    
    NSLayoutConstraint.activate([
      articleCellStackView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      articleCellStackView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      articleCellStackView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
      articleCellStackView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
    ])
  }
}
