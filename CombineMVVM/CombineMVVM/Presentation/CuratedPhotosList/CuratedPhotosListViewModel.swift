import Combine
import Foundation

final class CuratedPhotosListViewModel: ViewModelType {
  struct Input {
    let fetchPhotosByPage: AnyPublisher<Int, Never>
  }
  
  struct Output {
    let photos: AnyPublisher<[PhotoCellViewModel], Never>
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
          page: page, perPage: 10)
      })
      .map({ result in
        switch result {
        case .success(let photos):
          return self.viewModels(from: photos.photos)
        case .failure(_):
          return []
        }
      })
      .eraseToAnyPublisher()
    
    return Output(photos: photos)
  }
  
  private func viewModels(from photos: [Photo]) -> [PhotoCellViewModel] {
    return photos.map({ [unowned self] photo in
      return PhotoCellViewModelBuilder.createViewModel(
        from: photo,
        imageLoader: { [unowned self] photoToLoad in
          self.photosUseCase.loadImage(
            for: photoToLoad,
            sizedURL: photoToLoad.src.small
          )
        })
    })
  }
}
