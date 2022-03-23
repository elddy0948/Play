import Foundation

public protocol DownloadAvatarUseCaseProvider {
  func makeDownloadAvatarUseCase(_ path: String) -> DownloadAvatarUseCase
}
