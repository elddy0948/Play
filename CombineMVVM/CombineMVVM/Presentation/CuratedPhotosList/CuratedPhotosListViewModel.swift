import Combine
import Foundation

final class CuratedPhotosListViewModel: ViewModelType {
  struct Input {
    let fetchPhotosByPage: AnyPublisher<Int, Never>
  }
  
  struct Output {
    let photos: AnyPublisher<Photos, Never>
  }
  
  private let photosUseCase: PhotosUseCase
  var cancellables = [AnyCancellable]()
  
  init(photosUseCase: PhotosUseCase) {
    self.photosUseCase = photosUseCase
  }
  
  func transform(input: Input) -> Output {
    cancellables.forEach({ $0.cancel() })
    cancellables.removeAll()
    
    let photos = input.fetchPhotosByPage
      .flatMap({ [unowned self] page in
        self.photosUseCase.fetchCuratedPhotos(
          page: page, perPage: 15)
      })
      .map({ result in
        switch result {
        case .success(let photos):
          return photos
        case .failure(_):
          return Photos.empty()
        }
      })
      .eraseToAnyPublisher()
    
    return Output(photos: photos)
  }
}
