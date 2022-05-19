import Foundation
import RxSwift

final class EditPostViewModel: ViewModelType {
  struct Input {
    let editTrigger: Observable<Void>
    let deleteTrigger: Observable<Void>
    let title: Observable<String>
    let descriptions: Observable<String>
  }
  
  struct Output {
    let save: Observable<Void>
    let delete: Observable<Void>
    let post: Observable<Post>
  }
  
  private let post: Post
  private let useCase: PostsUseCase
  
  init(post: Post, useCase: PostsUseCase) {
    self.post = post
    self.useCase = useCase
  }
}

extension EditPostViewModel {
  func transform(_ input: Input) -> Output {
    let editing = input.editTrigger.scan(false, accumulator: { (editing, _) in
      return !editing
    }).startWith(false)
    
    let saveTrigger = editing.skip(1)
      .filter({ $0 == false })
      .mapToVoid()
    
    let titleAndDescriptions = Observable.combineLatest(input.title, input.descriptions)
    let post = Observable.combineLatest(
      Observable.just(self.post), titleAndDescriptions
    ) { (post, titleAndDescriptions) -> Post in
      return Post(title: titleAndDescriptions.0,
                  body: titleAndDescriptions.1,
                  uid: post.uid,
                  createdAt: post.createdAt
      )
    }.startWith(self.post)
    
    let savePost = saveTrigger.withLatestFrom(post)
      .flatMapLatest({ post in
        return self.useCase.save(post: post)
      })
    
    let deletePost = input.deleteTrigger
      .withLatestFrom(post)
      .flatMapLatest({ post in
        return self.useCase.delete(post: post)
      })
    return Output(
      save: savePost,
      delete: deletePost,
      post: post
    )
  }
}

