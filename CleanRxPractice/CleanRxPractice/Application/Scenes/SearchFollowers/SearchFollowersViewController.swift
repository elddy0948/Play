import UIKit
import RxCocoa
import RxSwift

final class SearchFollowersViewController: UIViewController {
  
  private let bag = DisposeBag()
  var viewModel: SearchFollowersViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    bindViewModel()
  }
  
  private func bindViewModel() {
    let viewWillAppear = self.rx.viewWillAppear
      .asObservable()
    
    let input = SearchFollowersViewModel.Input(
      viewWillAppear: viewWillAppear
    )
    
    let output = viewModel.transform(input)
    
    output.followers
      .drive(onNext: { followers in
        print(followers)
      })
      .disposed(by: bag)
  }
}
