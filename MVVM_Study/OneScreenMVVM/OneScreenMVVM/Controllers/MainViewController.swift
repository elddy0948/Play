import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
  //MARK: - Views
  @IBOutlet weak var greetingLabel: UILabel!
  
  //MARK: - Properties
  private let viewModel = MainViewModel()
  private let bag = DisposeBag()
  var user: User?

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    bindViewModel()
  }
  
  func bindViewModel() {
    guard let user = user else { return }
    let inputs = MainViewModel.Input(user: user)
    let outputs = viewModel.transform(input: inputs)
    
    outputs.greeting
      .drive(greetingLabel.rx.text)
      .disposed(by: bag)
  }
}
