import UIKit
import RxSwift

class ViewController: UIViewController {
  let one = 1, two = 2, three = 3
  
  let disposeBag = DisposeBag()
  var justObservable: Observable<Int>?
  var ofObservable: Observable<Int>?
  var fromObservable: Observable<[Int]>?
  var emptyObservable: Observable<Void>?
  var neverObservable: Observable<Void>?
  var rangeObservable: Observable<Int>?
  
  var labelText = "" {
    didSet {
      numberLabel.text = labelText
    }
  }
  
  @IBOutlet weak var numberLabel: UILabel!
  @IBOutlet weak var onCompletedLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    onCompletedLabel.text = "onCompleted: ❌"
    justObservable = Observable.just(one)
    ofObservable = Observable.of(one, two, three)
    fromObservable = Observable.from(optional: [one, two, three])
    
    emptyObservable = Observable.empty()
    neverObservable = Observable.never()
    rangeObservable = Observable.range(start: 1, count: 10)
  }
  
  @IBAction func justAction(_ sender: UIButton) {
    guard let justObservable = justObservable else { return }
    onCompletedLabel.text = "onCompleted: ❌"
    labelText = ""
    
    justObservable
      .subscribe(onNext: { [weak self] number in
        self?.labelText.append("\(number) ")
      },
      onCompleted: { [weak self] in
        DispatchQueue.main.async {
          self?.onCompletedLabel.text = "onCompleted: ✅"
        }
      })
      .disposed(by: disposeBag)
  }
  
  @IBAction func ofAction(_ sender: UIButton) {
    onCompletedLabel.text = "onCompleted: ❌"
    labelText = ""
    guard let ofObservable = ofObservable else { return }
    ofObservable
      .subscribe(onNext: { [weak self] number in
        self?.labelText.append("\(number)")
      },
      onCompleted: { [weak self] in
        DispatchQueue.main.async {
          self?.onCompletedLabel.text = "onCompleted: ✅"
        }
      })
      .disposed(by: disposeBag)
  }
  
  @IBAction func fromAction(_ sender: UIButton) {
    onCompletedLabel.text = "onCompleted: ❌"
    labelText = ""
    guard let fromObservable = fromObservable else { return }
    fromObservable
      .subscribe(onNext: { [weak self] number in
        self?.labelText.append("\(number) ")
      },
      onCompleted: { [weak self] in
        DispatchQueue.main.async {
          self?.onCompletedLabel.text = "onCompleted: ✅"
        }
      })
      .disposed(by: disposeBag)
  }
  
  @IBAction func emptyAction(_ sender: UIButton) {
    onCompletedLabel.text = "onCompleted: ❌"
    labelText = ""
    
    guard let emptyObservable = emptyObservable else { return }
    
    emptyObservable
      .subscribe(onCompleted: { [weak self] in
        DispatchQueue.main.async {
          self?.onCompletedLabel.text = "onCompleted: ✅"
        }
      })
      .disposed(by: disposeBag)
  }
  
  @IBAction func neverAction(_ sender: UIButton) {
    onCompletedLabel.text = "onCompleted: ❌"
    labelText = ""
    
    guard let neverObservable = neverObservable else { return }
    
    neverObservable
      .subscribe(onCompleted: { [weak self] in
        DispatchQueue.main.async {
          self?.onCompletedLabel.text = "onCompleted: ✅"
        }
      })
      .disposed(by: disposeBag)
  }
  
  @IBAction func rangeOneToTenAction(_ sender: UIButton) {
    onCompletedLabel.text = "onCompleted: ❌"
    labelText = ""
    
    guard let rangeObservable = rangeObservable else { return }
    
    rangeObservable
      .subscribe(onNext: { [weak self] number in
        self?.labelText.append("\(number)")
      },
      onCompleted: { [weak self] in
        DispatchQueue.main.async {
          self?.onCompletedLabel.text = "onCompleted: ✅"
        }
      })
      .disposed(by: disposeBag)
  }
}

