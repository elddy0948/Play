import UIKit
import RxSwift

class ViewController: UIViewController {
  
  //MARK: - IBOutlets
  @IBOutlet weak var americanoLabel: UILabel!
  @IBOutlet weak var latteLabel: UILabel!
  @IBOutlet weak var redbullLabel: UILabel!
  @IBOutlet weak var hotsixLabel: UILabel!
  @IBOutlet weak var monsterLabel: UILabel!
  @IBOutlet weak var totalMgLabel: UILabel!
  @IBOutlet weak var emojiLabel: UILabel!
  
  private let user = User()
  private let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    resetLabels()
  }
  
  private func resetLabels() {
    americanoLabel.text = "아메리카노 x0"
    latteLabel.text = "라떼 x0"
    redbullLabel.text = "레드불 x0"
    hotsixLabel.text = "핫식스 x0"
    monsterLabel.text = "몬스터 x0"
    totalMgLabel.text = "0 mg"
    emojiLabel.text = "😃"
  }
  
  private func updateUI(with user: User) {
    americanoLabel.text = "아메리카노 x\(user.americano)"
    latteLabel.text = "라떼 x\(user.latte)"
    redbullLabel.text = "레드불 x\(user.redbull)"
    hotsixLabel.text = "핫식스 x\(user.hotsix)"
    monsterLabel.text = "몬스터 x\(user.monster)"
    totalMgLabel.text = "\(user.totalMg) mg"
    switch user.totalMg {
    case 0...200:
      emojiLabel.text = "😀"
    case 201...400:
      emojiLabel.text = "🤨"
    case 401...600:
      emojiLabel.text = "😫"
    case 601...:
      emojiLabel.text = "😵"
    default:
      emojiLabel.text = "😀"
    }
  }
  
  @IBAction func editAction(_ sender: UIBarButtonItem) {
    let editCaffeineViewController = storyboard!.instantiateViewController(withIdentifier: "EditCaffeineViewController") as! EditCaffeineViewController
    editCaffeineViewController.configureObservable(with: user)
    editCaffeineViewController.userObservable?
      .subscribe(onNext: { [weak self] user in
        self?.updateUI(with: user)
      }, onCompleted: {
        print("Completed!")
      })
      .disposed(by: disposeBag)
    navigationController?.pushViewController(editCaffeineViewController, animated: true)
  }
}

