import Foundation
import RxSwift

final class PostsViewModel: ViewModelType {
  struct Input {
    let trigger: Observable<Void>
  }
  
  struct Output {
    let posts: Observable<[Post]>
  }
  
  private let useCase: PostsUseCase
  
  init(useCase: PostsUseCase) {
    self.useCase = useCase
  }
  
  func transform(_ input: Input) -> Output {
    let posts = input.trigger.flatMapLatest({
      return self.useCase.posts()
    })
    
    return Output(posts: posts)
  }
}
