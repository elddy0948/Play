import UIKit
import RxSwift
import RxRelay

class BehaviorRelayViewController: UIViewController {
  
  //MARK: - Outlets
  @IBOutlet weak var behaviorRelayLabel: UILabel!
  @IBOutlet weak var firstSubscribeLabel: UILabel!
  @IBOutlet weak var currentValueLabel: UILabel!
  
  //MARK: - Properties
  let disposeBag = DisposeBag()
  var number = 1
  
  //MARK: - Relay
  let behaviorRelay = BehaviorRelay<Int>(value: 0)
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func onNextAction(_ sender: UIButton) {
    behaviorRelay.accept(number)
    behaviorRelayLabel.text?.append("\(number)")
    number += 1
  }
  
  @IBAction func firstSubscribeAction(_ sender: UIButton) {
    firstSubscribeLabel.text = "1) "
    firstSubscribeLabel.backgroundColor = .systemBlue
    
    behaviorRelay
      .subscribe(onNext: { [weak self] number in
        self?.firstSubscribeLabel.text?.append("\(number)")
      })
      .disposed(by: disposeBag)
  }
  
  @IBAction func showCurrentValueAction(_ sender: UIButton) {
    currentValueLabel.text = "\(behaviorRelay.value)"
  }
}
