import UIKit

class UserDetailView: UIView {
  //MARK: - Views
  lazy var userDetailStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.distribution = .fill
    stackView.axis = .vertical
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
  
  private var user: User?
  
  init(user: User?) {
    super.init(frame: .zero)
    self.user = user
    
    setupUserDetailStackView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    user = nil
  }
}

extension UserDetailView {
  private func setupUserDetailStackView() {
    addSubview(userDetailStackView)
    userDetailStackView
      .translatesAutoresizingMaskIntoConstraints = false
    
    setupNameLabel()
    setupBioLabel()
    setupFollowStackView()
    setupFollowersLabel()
    setupFollowingLabel()
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
    followersLabel.text = "\(user?.followers ?? 0)"
  }
  
  private func setupFollowingLabel() {
    followHorizontalStackView
      .addArrangedSubview(followingLabel)
    followingLabel.text = "\(user?.following ?? 0)"
  }
}
