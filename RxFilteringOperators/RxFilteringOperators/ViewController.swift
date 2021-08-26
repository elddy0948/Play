import UIKit
import RxSwift

class ViewController: UIViewController {
  
  //MARK: - IBOutlets
  @IBOutlet weak var publishSubjectLabel: UILabel!
  @IBOutlet weak var firstSubscriberLabel: UILabel!
  
  private let publishSubject = PublishSubject<Int>()
  private let disposeBag = DisposeBag()
  
  private var number = 1

  override func viewDidLoad() {
    super.viewDidLoad()
    publishSubjectLabel.text = ""
    firstSubscriberLabel.text = ""
  }
  
  //MARK: - IBActions
  @IBAction func firstSubscribeAction(_ sender: UIButton) {
    firstSubscriberLabel.text = "1) "
    publishSubject
      .ignoreElements()
      .subscribe(onNext: { [weak self] number in
        self?.firstSubscriberLabel.text?.append("\(number)")
      }, onCompleted: { [weak self] in
        self?.firstSubscriberLabel.text?.append("✅")
      })
      .disposed(by: disposeBag)
    sender.isEnabled = false
  }
  
  @IBAction func onNextAction(_ sender: UIButton) {
    publishSubject.onNext(number)
    publishSubjectLabel.text?.append("\(number)")
    number += 1
  }
  
  @IBAction func onCompletedAction(_ sender: UIButton) {
    publishSubject.onCompleted()
    publishSubjectLabel.text?.append("✅")
  }
}

