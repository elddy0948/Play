import UIKit
import RxSwift

class FilterViewController: UIViewController {
  
  @IBOutlet weak var publishSubjectLabel: UILabel!
  @IBOutlet weak var firstSubscribeLabel: UILabel!
  
  private let publishSubject = PublishSubject<Int>()
  private let disposeBag = DisposeBag()
  private var number = 1
  
  override func viewDidLoad() {
    super.viewDidLoad()
    publishSubjectLabel.text = ""
    firstSubscribeLabel.text = ""
  }
  
  @IBAction func firstSubscribeAction(_ sender: UIButton) {
    firstSubscribeLabel.text = "1) "
    publishSubject
      .filter { $0 < 2 }
      .subscribe(onNext: { [weak self] number in
        self?.firstSubscribeLabel.text?.append("\(number)")
      }, onCompleted: { [weak self] in
        self?.firstSubscribeLabel.text?.append("✅")
      })
      .disposed(by: disposeBag)
    sender.isEnabled = false
  }
  
  @IBAction func onNextAction(_ sender: UIButton) {
    publishSubjectLabel.text?.append("\(number)")
    publishSubject.onNext(number)
    number += 1
  }
  
  @IBAction func onCompletedAction(_ sender: UIButton) {
    publishSubject.onCompleted()
    publishSubjectLabel.text?.append("✅")
  }
}
