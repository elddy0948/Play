import UIKit
import RxSwift

class BehaviorSubjectViewController: UIViewController {
  
  //MARK: - IBOutlets
  @IBOutlet weak var behaviorSubjectLabel: UILabel!
  @IBOutlet weak var firstSubscriberLabel: UILabel!
  @IBOutlet weak var secondSubscriberLabel: UILabel!
  
  //MARK: - Properties
  let disposeBag = DisposeBag()
  var number = 1
  
  //MARK: - Subject
  let behaviorSubject = BehaviorSubject<Int>(value: 0)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  //MARK: - IBActions
  @IBAction func onNextAction(_ sender: UIButton) {
    behaviorSubject.onNext(number)
    behaviorSubjectLabel.text?.append("\(number)")
    number += 1
  }
  
  @IBAction func firstSubscriberAction(_ sender: UIButton) {
    sender.isEnabled = false
    firstSubscriberLabel.text = "1)"
    behaviorSubject
      .subscribe(onNext: { [weak self] number in
        self?.firstSubscriberLabel.text?.append("\(number)")
      },
      onCompleted: { [weak self] in
        self?.firstSubscriberLabel.text?.append("✅")
      })
      .disposed(by: disposeBag)
  }
  
  @IBAction func secondSubscriberAction(_ sender: UIButton) {
    sender.isEnabled = false
    secondSubscriberLabel.text = "2)"
    behaviorSubject
      .subscribe(onNext: { [weak self] number in
        self?.secondSubscriberLabel.text?.append("\(number)")
      },
      onCompleted: { [weak self] in
        self?.secondSubscriberLabel.text?.append("✅")
      })
      .disposed(by: disposeBag)
  }
  
  @IBAction func onCompletedAction(_ sender: UIButton) {
    sender.isEnabled = false
    behaviorSubject.onCompleted()
  }
}
