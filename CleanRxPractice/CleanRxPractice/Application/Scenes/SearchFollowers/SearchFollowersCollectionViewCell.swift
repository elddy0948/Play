import UIKit
import RxSwift


final class SearchFollowersCollectionViewCell: UICollectionViewCell {
  static let reuseIdentifier = String(describing: SearchFollowersCollectionViewCell.self)
  
  private lazy var avatarImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  private lazy var loginLabel: UILabel = {
    let label = UILabel()
    label.textColor = .label
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.textAlignment = .center
    label.numberOfLines = 0
    return label
  }()
  
  private var downloadAvatarUseCase: DownloadAvatarUseCase?
  private let bag = DisposeBag()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    layout()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  func configureData(
    _ viewmodel: SearchFollowersItemViewModel,
    downloadAvatarUseCase: DownloadAvatarUseCase?
  ) {
    loginLabel.text = viewmodel.login
    self.downloadAvatarUseCase = downloadAvatarUseCase
    
    if let url = viewmodel.avatarURL {
      downloadAvatar(url)
    }
  }
  
  private func downloadAvatar(_ path: String) {
    downloadAvatarUseCase?.download(path)
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { data in
        let image = UIImage(data: data)
        self.avatarImageView.image = image
      })
      .disposed(by: bag)
  }
}

//MARK: - UI Setup / Layout
extension SearchFollowersCollectionViewCell {
  private func layout() {
    contentView.addSubview(avatarImageView)
    contentView.addSubview(loginLabel)
    loginLabel.translatesAutoresizingMaskIntoConstraints = false
    avatarImageView.translatesAutoresizingMaskIntoConstraints = false
    
    avatarImageView.setContentHuggingPriority(UILayoutPriority(252), for: .vertical)
    loginLabel.setContentHuggingPriority(UILayoutPriority(251), for: .vertical)
    
    NSLayoutConstraint.activate([
      avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      loginLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
      loginLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      loginLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      loginLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
    ])
  }
}
