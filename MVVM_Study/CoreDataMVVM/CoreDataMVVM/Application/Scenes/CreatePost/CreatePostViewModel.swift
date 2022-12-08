import Foundation
import RxSwift

final class CreatePostViewModel: ViewModelType {
  struct Input {
    let save: Observable<Void>
    let title: Observable<String>
    let descriptions: Observable<String>
  }
  
  struct Output {
    let dismiss: Observable<Void>
  }
  
  private let createPostUseCase: PostsUseCase
  
  init(createPostUseCase: PostsUseCase) {
    self.createPostUseCase = createPostUseCase
  }
  
  func transform(_ input: Input) -> Output {
    let titleAndDescriptions = Observable.combineLatest(input.title, input.descriptions)
    let save = input.save.withLatestFrom(titleAndDescriptions)
      .map({ (title, descriptions) in
        return Post(
          title: title, body: descriptions, uid: UUID().uuidString, createdAt: Date().formatted()
        )
      })
      .flatMapLatest({ [unowned self] post in
        return self.createPostUseCase.save(post: post)
      })
    let dismiss = save.do()
    
    return Output(dismiss: dismiss)
  }
}
