import UIKit
import RxSwift
import RxRelay

class ViewController: UIViewController {
  
  //MARK: - Outlets
  @IBOutlet weak var publishRelayLabel: UILabel!
  @IBOutlet weak var firstSubscriberLabel: UILabel!
  
  let disposeBag = DisposeBag()
  var number = 1
  
  let publishRelay = PublishRelay<Int>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func onNextAction(_ sender: UIButton) {
    publishRelay.accept(number)
    publishRelayLabel.text?.append("\(number)")
    number += 1
  }
  
  @IBAction func firstSubscribeAction(_ sender: UIButton) {
    sender.isEnabled = false
    firstSubscriberLabel.backgroundColor = .systemBlue
    firstSubscriberLabel.text = "1)"
    publishRelay
      .subscribe(onNext: { [weak self] number in
        self?.firstSubscriberLabel.text?.append("\(number)")
      })
      .disposed(by: disposeBag)
  }
}

