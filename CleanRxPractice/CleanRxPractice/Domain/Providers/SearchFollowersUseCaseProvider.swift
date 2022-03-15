import Foundation

public protocol SearchFollowersUseCaseProvider {
  func makeSearchFollowersUseCase() -> SearchFollowersUseCase
}
