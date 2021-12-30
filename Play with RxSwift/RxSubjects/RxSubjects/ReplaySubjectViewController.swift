import UIKit
import RxSwift

class ReplaySubjectViewController: UIViewController {
  
  //MARK: - IBOutlets
  @IBOutlet weak var replaySubjectLabel: UILabel!
  @IBOutlet weak var firstSubscriberLabel: UILabel!
  @IBOutlet weak var secondSubscriberLabel: UILabel!
  
  //MARK: - Properties
  let disposeBag = DisposeBag()
  var number = 1
  
  //MARK: - Subject
  let replaySubject = ReplaySubject<Int>.create(bufferSize: 2)
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  //MARK: - IBActions
  @IBAction func onNextAction(_ sender: UIButton) {
    replaySubject.onNext(number)
    replaySubjectLabel.text?.append("\(number)")
    number += 1
  }
  
  @IBAction func firstSubscriberAction(_ sender: UIButton) {
    sender.isEnabled = false
    firstSubscriberLabel.text = "1)"
    replaySubject
      .subscribe(onNext: { [weak self] number in
        self?.firstSubscriberLabel.text?.append("\(number)")
      },
      onError: { [weak self] error in
        self?.firstSubscriberLabel.text?.append("❌")
      },
      onCompleted: { [weak self] in
        self?.firstSubscriberLabel.text?.append("✅")
      })
      .disposed(by: disposeBag)
  }
  
  @IBAction func secondSubscriberAction(_ sender: UIButton) {
    sender.isEnabled = false
    secondSubscriberLabel.text = "2)"
    replaySubject
      .subscribe(onNext: { [weak self] number in
        self?.secondSubscriberLabel.text?.append("\(number)")
      },
      onError: { [weak self] _ in
        self?.secondSubscriberLabel.text?.append("❌")
      },
      onCompleted: { [weak self] in
        self?.secondSubscriberLabel.text?.append("✅")
      })
      .disposed(by: disposeBag)
  }
  
  @IBAction func onCompletedAction(_ sender: UIButton) {
    sender.isEnabled = false
    replaySubject.onCompleted()
  }
  
  @IBAction func onErroprAction(_ sender: UIButton) {
    sender.isEnabled = false
    replaySubject.onError(MyError.errorOccur)
  }
  
  enum MyError: Error {
    case errorOccur
  }
}
