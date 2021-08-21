import UIKit
import RxSwift

class ViewController: UIViewController {
  let one = 1, two = 2, three = 3
  
  let disposeBag = DisposeBag()
  var justObservable: Observable<Int>?
  var ofObservable: Observable<Int>?
  var fromObservable: Observable<[Int]>?
  var labelText = "" {
    didSet {
      numberLabel.text = labelText
    }
  }
  
  @IBOutlet weak var numberLabel: UILabel!
  @IBOutlet weak var onCompletedLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    onCompletedLabel.text = "❌"
    justObservable = Observable.just(one)
    ofObservable = Observable.of(one, two, three)
    fromObservable = Observable.from(optional: [one, two, three])
  }
  
  @IBAction func justAction(_ sender: UIButton) {
    guard let justObservable = justObservable else { return }
    onCompletedLabel.text = "❌"
    labelText = ""
    
    justObservable
      .subscribe(onNext: { [weak self] number in
        self?.labelText.append("\(number) ")
      },
      onCompleted: { [weak self] in
        DispatchQueue.main.async {
          self?.onCompletedLabel.text = "✅"
        }
      })
      .disposed(by: disposeBag)
  }
  
  @IBAction func ofAction(_ sender: UIButton) {
    onCompletedLabel.text = "❌"
    labelText = ""
    guard let ofObservable = ofObservable else { return }
    ofObservable
      .subscribe(onNext: { [weak self] number in
        self?.labelText.append("\(number)")
      },
      onCompleted: { [weak self] in
        DispatchQueue.main.async {
          self?.onCompletedLabel.text = "✅"
        }
      })
      .disposed(by: disposeBag)
  }
  
  @IBAction func fromAction(_ sender: UIButton) {
    onCompletedLabel.text = "❌"
    labelText = ""
    guard let fromObservable = fromObservable else { return }
    fromObservable
      .subscribe(onNext: { [weak self] number in
        self?.labelText.append("\(number) ")
      },
      onCompleted: { [weak self] in
        DispatchQueue.main.async {
          self?.onCompletedLabel.text = "✅"
        }
      })
      .disposed(by: disposeBag)
  }
}

