import Foundation
import RxSwift
import RxCocoa

final class SearchFollowersViewModel: ViewModelType {
  struct Input {
    let viewWillAppear: Observable<Bool>
  }
  
  struct Output {
    let followers: Driver<[Follower]>
  }
  
  private let useCase: SearchFollowersUseCase
  
  init(useCase: SearchFollowersUseCase) {
    self.useCase = useCase
  }
  
  func transform(_ input: Input) -> Output {
    let followers = input.viewWillAppear.flatMapLatest({ _ in
      return self.useCase.search(username: "elddy0948")
    }).asDriver(onErrorJustReturn: [])
    
    return Output(followers: followers)
  }
}
