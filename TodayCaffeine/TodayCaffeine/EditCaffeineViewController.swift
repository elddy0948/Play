import UIKit
import RxSwift

class EditCaffeineViewController: UIViewController {
  
  @IBOutlet weak var americanoLabel: UILabel!
  @IBOutlet weak var latteLabel: UILabel!
  @IBOutlet weak var redbullLabel: UILabel!
  @IBOutlet weak var hotsixLabel: UILabel!
  @IBOutlet weak var monsterLabel: UILabel!
  @IBOutlet weak var americanoStepper: UIStepper!
  @IBOutlet weak var latteStepper: UIStepper!
  @IBOutlet weak var redbullStepper: UIStepper!
  @IBOutlet weak var hotsixStepper: UIStepper!
  @IBOutlet weak var monsterStepper: UIStepper!
  
  var user: User?
  
  //MARK: - Subject
  private var userSubject: BehaviorSubject<User>?
  var userObservable: Observable<User>?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let user = user {
      configureValue(with: user)
    }
  }
  
  func configureObservable(with user: User) {
    self.user = user
    userSubject = BehaviorSubject<User>(value: user)
    userObservable = userSubject?.asObserver()
  }
  
  private func configureValue(with user: User) {
    americanoLabel.text = "아메리카노 x\(user.americano)"
    latteLabel.text = "라떼 x\(user.latte)"
    redbullLabel.text = "레드불 x\(user.redbull)"
    hotsixLabel.text = "핫식스 x\(user.hotsix)"
    monsterLabel.text = "몬스터 x\(user.monster)"
    
    americanoStepper.value = Double(user.americano)
    latteStepper.value = Double(user.latte)
    redbullStepper.value = Double(user.redbull)
    hotsixStepper.value = Double(user.hotsix)
    monsterStepper.value = Double(user.monster)
  }
  
  @IBAction func americanoStepper(_ sender: UIStepper) {
    guard let user = user else { return }
    americanoLabel.text = "아메리카노 x\(Int(sender.value))"
    user.americano = Int(sender.value)
    user.totalMg += 150
    userSubject?.onNext(user)
  }
  
  @IBAction func latteStepper(_ sender: UIStepper) {
    guard let user = user else { return }
    latteLabel.text = "라떼 x\(Int(sender.value))"
    user.latte = Int(sender.value)
    user.totalMg += 75
    userSubject?.onNext(user)
  }
  
  @IBAction func redbullStepper(_ sender: UIStepper) {
    guard let user = user else { return }
    redbullLabel.text = "레드불 x\(Int(sender.value))"
    user.redbull = Int(sender.value)
    user.totalMg += 25
    userSubject?.onNext(user)
  }
  
  @IBAction func hotsixStepper(_ sender: UIStepper) {
    guard let user = user else { return }
    hotsixLabel.text = "핫식스 x\(Int(sender.value))"
    user.hotsix = Int(sender.value)
    user.totalMg += 32
    userSubject?.onNext(user)
  }
  
  @IBAction func monsterStepper(_ sender: UIStepper) {
    guard let user = user else { return }
    monsterLabel.text = "몬스터 x\(Int(sender.value))"
    user.monster = Int(sender.value)
    user.totalMg += 33
    userSubject?.onNext(user)
  }
}
