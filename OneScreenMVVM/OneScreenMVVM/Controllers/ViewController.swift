import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

  //MARK: - Views
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var signinButton: UIButton!
  @IBOutlet weak var signInLabel: UILabel!
  
  //MARK: - Properties
  private let viewModel = SigninViewModel()
  private let bag = DisposeBag()
  private var user: User?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let inputs = SigninViewModel.Input(
      email: emailTextField.rx.text.orEmpty.asObservable(),
      password: passwordTextField.rx.text.orEmpty.asObservable(),
      signin: signinButton.rx.tap.asObservable()
    )
    
    let outputs = viewModel.transform(input: inputs)
    
    outputs.user
      .subscribe(onNext: { [weak self] user in
        self?.user = user
        self?.performSegue(withIdentifier: "ShowMain", sender: self)
      })
      .disposed(by: bag)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    guard let viewController = segue.destination as? MainViewController else { return }
    viewController.user = user
  }
  
  private func navigateToMainViewController(with user: User) {
    let viewController = MainViewController()
    viewController.user = user
    self.navigationController?.pushViewController(viewController, animated: true)
  }
}

