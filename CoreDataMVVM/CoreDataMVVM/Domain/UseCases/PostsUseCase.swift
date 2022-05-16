import Foundation
import RxSwift

protocol PostsUseCase {
  func posts() -> Observable<[Post]>
  func save(post: Post) -> Observable<Void>
  func delete(post: Post) -> Observable<Void>
}
