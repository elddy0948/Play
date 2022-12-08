import Foundation

final class CDUseCaseProvider: UseCaseProvider {
  private let coreDataStack = CoreDataStack()
  private let postRepository: Repository<Post>
  
  init() {
    postRepository = Repository<Post>(context: coreDataStack.context)
  }
  
  func makePostsUseCase() -> PostsUseCase {
    return CDPostsUseCase(repository: postRepository)
  }
}
