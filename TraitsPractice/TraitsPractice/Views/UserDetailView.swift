import UIKit

protocol UserDetailViewDelegate: AnyObject {
  func didTappedLikeButton(_ view: UserDetailView)
}

class UserDetailView: UIView {
  //MARK: - Views
  lazy var userDetailStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.distribution = .equalSpacing
    stackView.axis = .vertical
    stackView.spacing = 8
    return stackView
  }()
  
  lazy var followHorizontalStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.distribution = .fillEqually
    stackView.axis = .horizontal
    return stackView
  }()
  
  lazy var nameLabel = ProfileLabel(
    font: UIFont.preferredFont(
      forTextStyle: .title1
    ),
    tintColor: .label
  )
  
  lazy var bioLabel = ProfileLabel(
    font: UIFont.preferredFont(
      forTextStyle: .body
    ),
    tintColor: .systemGray
  )
  
  lazy var followersLabel = ProfileLabel(
    font: UIFont.preferredFont(
      forTextStyle: .footnote
    ),
    tintColor: .label
  )
  
  lazy var followingLabel = ProfileLabel(
    font: UIFont.preferredFont(
      forTextStyle: .footnote
    ),
    tintColor: .label
  )
  
  lazy var likeButton: UIButton = {
    let button = UIButton()
    button.setTitle("Like!", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = .systemPurple
    button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    return button
  }()
  
  private var user: User?
  
  weak var delegate: UserDetailViewDelegate?
  
  init(user: User?) {
    super.init(frame: .zero)
    self.user = user
    
    setupUserDetailStackView()
    layout()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    user = nil
  }
  
  @objc func likeButtonTapped(_ sender: UIButton) {
    delegate?.didTappedLikeButton(self)
  }
}

extension UserDetailView {
  private func setupUserDetailStackView() {
    addSubview(userDetailStackView)
    userDetailStackView
      .translatesAutoresizingMaskIntoConstraints = false
    userDetailStackView.backgroundColor = .systemGray
    
    setupNameLabel()
    setupBioLabel()
    setupFollowStackView()
    setupFollowersLabel()
    setupFollowingLabel()
    setupLikeButton()
  }
  
  private func setupNameLabel() {
    userDetailStackView.addArrangedSubview(nameLabel)
    nameLabel.text = user?.name
  }
  
  private func setupBioLabel() {
    userDetailStackView.addArrangedSubview(bioLabel)
    bioLabel.text = user?.bio
  }
  
  private func setupFollowStackView() {
    userDetailStackView
      .addArrangedSubview(followHorizontalStackView)
  }
  
  private func setupFollowersLabel() {
    followHorizontalStackView
      .addArrangedSubview(followersLabel)
    followersLabel.numberOfLines = 0
    followersLabel.text = "Followers\n\(user?.followers ?? 0)"
  }
  
  private func setupFollowingLabel() {
    followHorizontalStackView
      .addArrangedSubview(followingLabel)
    followingLabel.numberOfLines = 0
    followingLabel.text = "Following\n\(user?.following ?? 0)"
  }
  
  private func setupLikeButton() {
    userDetailStackView.addArrangedSubview(likeButton)
    
    likeButton.layer.cornerRadius = 8
    likeButton.layer.masksToBounds = false
    likeButton.addTarget(
      self,
      action: #selector(likeButtonTapped(_:)),
      for: .primaryActionTriggered
    )
  }
}

extension UserDetailView {
  private func layout() {
    NSLayoutConstraint.activate([
      userDetailStackView.topAnchor.constraint(
        equalTo: topAnchor
      ),
      userDetailStackView.leadingAnchor.constraint(
        equalTo: leadingAnchor
      ),
      userDetailStackView.trailingAnchor.constraint(
        equalTo: trailingAnchor
      ),
      userDetailStackView.bottomAnchor.constraint(
        equalTo: bottomAnchor
      ),
    ])
  }
}
