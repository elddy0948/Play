import Foundation
import RxSwift
import RxCocoa

final class SearchFollowersViewModel: ViewModelType {
  struct Input {
    let viewWillAppear: Observable<Bool>
  }
  
  struct Output {
    let followers: Driver<[SearchFollowersItemViewModel]>
  }
  
  private let useCase: SearchFollowersUseCase
  
  init(useCase: SearchFollowersUseCase) {
    self.useCase = useCase
  }
  
  func transform(_ input: Input) -> Output {
    let followers = input.viewWillAppear.flatMapLatest({ _ in
      return self.useCase.search(username: "elddy0948")
    }).map({ followers in
      followers.map({ follower -> SearchFollowersItemViewModel in
        print(follower.avatarURL)
        return SearchFollowersItemViewModel(follower)
      })
    }).asDriver(onErrorJustReturn: [])
    
    return Output(followers: followers)
  }
}

struct SearchFollowersItemViewModel {
  let login: String
  let avatarURL: String?
}

extension SearchFollowersItemViewModel {
  init(_ follower: Follower) {
    self.login = follower.login
    self.avatarURL = follower.avatarURL
  }
}
