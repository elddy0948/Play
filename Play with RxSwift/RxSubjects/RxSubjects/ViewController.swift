import UIKit
import RxSwift

class ViewController: UIViewController {
  
  //MARK: - IBOutlets
  @IBOutlet weak var publishSubjectLabel: UILabel!
  @IBOutlet weak var firstSubscriberLabel: UILabel!
  @IBOutlet weak var secondSubscriberLabel: UILabel!
  
  //MARK: - Properties
  let disposeBag = DisposeBag()
  var number = 1
  
  //MARK: - Subjects
  let publishSubject = PublishSubject<Int>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  //MARK: - IBActions
  @IBAction func onNextAction(_ sender: UIButton) {
    publishSubject.onNext(number)
    publishSubjectLabel.text?.append("\(number)")
    number += 1
  }
  
  @IBAction func firstSubscriberAction(_ sender: UIButton) {
    sender.isEnabled = false
    firstSubscriberLabel.text = "1)"
    publishSubject
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
    publishSubject
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
    publishSubject.onCompleted()
  }
}

