import UIKit
import RxSwift

class SecondViewController: UIViewController {
  
  //MARK: - Outlets
  @IBOutlet weak var numberLabel: UILabel!
  @IBOutlet weak var onCompletedLabel: UILabel!
  
  //MARK: - Observables
  var createObservable: Observable<Int>?
  var deferredObservable: Observable<Int>?
  
  //MARK: - Properties
  let disposeBag = DisposeBag()
  var flag = false
  var textLabel = "" {
    didSet {
      DispatchQueue.main.async { [weak self] in
        self?.numberLabel.text = self?.textLabel
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    createObservable = Observable<Int>.create({ observer in
      observer.onNext(1)
      observer.onNext(2)
      observer.onCompleted()
      observer.onNext(3)
      
      return Disposables.create()
    })
    
    deferredObservable = Observable<Int>.deferred({ [weak self] in
      guard let flag = self?.flag else { return Observable.error(CustomError.myError) }
      if flag {
        return Observable<Int>.of(1, 2, 3)
      } else {
        return Observable<Int>.of(4, 5, 6)
      }
    })
  }
  
  //MARK: - Actions
  @IBAction func createAction(_ sender: UIButton) {
    onCompletedLabel.text = "onCompleted: ❌"
    textLabel = ""
    numberLabel.text = textLabel
    
    guard let createObservable = createObservable else { return }
    
    createObservable
      .subscribe(onNext: { [weak self] number in
        self?.textLabel.append("\(number)")
      },
      onCompleted: { [weak self] in
        self?.onCompletedLabel.text = "onCompleted: ✅"
      })
      .disposed(by: disposeBag)
  }
  
  @IBAction func deferredAction(_ sender: UIButton) {
    onCompletedLabel.text = "onCompleted: ❌"
    textLabel = ""
    numberLabel.text = textLabel
    
    guard let deferredObservable = deferredObservable else { return }
    
    deferredObservable
      .subscribe(onNext: { [weak self] number in
        self?.textLabel.append("\(number)")
      },
      onCompleted: { [weak self] in
        self?.flag.toggle()
        self?.onCompletedLabel.text = "onCompleted: ✅"
      })
      .disposed(by: disposeBag)
  }
  
  enum CustomError: Error {
    case myError
  }
}
