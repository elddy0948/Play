import UIKit
import RxSwift

class UserDetailViewController: UIViewController {
  
  lazy var userDetailView: UserDetailView = {
    let userDetailView = UserDetailView(user: self.user)
    return userDetailView
  }()
  var user: User?
  
  private let bag = DisposeBag()
  
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
    view.backgroundColor = .systemBackground
    setupUserDetailView()
    layout()
  }
  
  private func setupUserDetailView() {
    view.addSubview(userDetailView)
    userDetailView
      .translatesAutoresizingMaskIntoConstraints = false
    userDetailView.delegate = self
  }
  
  private func layout() {
    let safeAreaLayoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      userDetailView.centerYAnchor.constraint(
        equalTo: safeAreaLayoutGuide.centerYAnchor
      ),
      userDetailView.leadingAnchor.constraint(
        equalTo: safeAreaLayoutGuide.leadingAnchor,
        constant: 8
      ),
      userDetailView.trailingAnchor.constraint(
        equalTo: safeAreaLayoutGuide.trailingAnchor,
        constant: -8
      ),
    ])
  }
}

extension UserDetailViewController: UserDetailViewDelegate {
  func didTappedLikeButton(_ view: UserDetailView) {
    guard let user = user,
          let username = user.name else {
            return
          }
    UserNetworkingAPI.shared.likeUser(with: username)
      .subscribe(
        onCompleted: {
          print("You liked him/her !")
        },
        onError: { error in
          print("Oh no! error occured!")
        },
        onDisposed: {}
      )
      .disposed(by: bag)
  }
}
