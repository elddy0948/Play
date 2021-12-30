import UIKit
import RxSwift

class ArticleTableViewCell: UITableViewCell {
  static let reuseIdentifier = String(describing: ArticleTableViewCell.self)
  
  private lazy var articleCellStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  private lazy var activityIndicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(style: .medium)
    indicator.hidesWhenStopped = true
    return indicator
  }()
  
  private lazy var articleImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
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
  
  var disposable = SingleAssignmentDisposable()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupLayoutUI()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupLayoutUI()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    articleImageView.image = nil
    disposable.dispose()
    disposable = SingleAssignmentDisposable()
  }
  
  func setupCellData(with articleViewModel: ArticleViewModel) {
    titleLabel.text = articleViewModel.title
    descriptionLabel.text = articleViewModel.description
    authorLabel.text = articleViewModel.author
    if let imageUrl = articleViewModel.imageUrl {
      downloadImage(with: imageUrl)
    }
  }
  
  func downloadImage(with url: String) {
    activityIndicator.startAnimating()
    let s = ArticleService.shared.downloadImage(url: url)
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] image in
        guard let self = self else { return }
        self.articleImageView.image = image
        self.activityIndicator.stopAnimating()
      })
    disposable.setDisposable(s)
  }
  
  private func setupLayoutUI() {
    contentView.addSubview(articleCellStackView)
    articleCellStackView.addArrangedSubview(articleImageView)
    articleCellStackView.addArrangedSubview(titleLabel)
    articleCellStackView.addArrangedSubview(descriptionLabel)
    articleCellStackView.addArrangedSubview(authorLabel)
    
    let layoutGuide = contentView.readableContentGuide
    articleImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    
    NSLayoutConstraint.activate([
      articleCellStackView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      articleCellStackView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      articleCellStackView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
      articleCellStackView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
    ])
  }
}
