import UIKit


class UserDetailViewController: UIViewController {
  
  lazy var userDetailView: UserDetailView = {
    let userDetailView = UserDetailView(user: self.user)
    return userDetailView
  }()
  var user: User?
  
  init(user: User) {
    super.init(nibName: nil, bundle: nil)
    self.user = user
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    user = nil
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUserDetailView()
    layout()
  }
  
  private func setupUserDetailView() {
    view.addSubview(userDetailView)
    userDetailView
      .translatesAutoresizingMaskIntoConstraints = false
  }
  
  private func layout() {
    let readableContent = view.readableContentGuide
    NSLayoutConstraint.activate([
      userDetailView.topAnchor.constraint(
        equalTo: readableContent.topAnchor,
        constant: 16
      ),
      userDetailView.leadingAnchor.constraint(
        equalTo: readableContent.leadingAnchor,
        constant: 8
      ),
      userDetailView.trailingAnchor.constraint(
        equalTo: readableContent.trailingAnchor,
        constant: -8
      )
    ])
  }
}
