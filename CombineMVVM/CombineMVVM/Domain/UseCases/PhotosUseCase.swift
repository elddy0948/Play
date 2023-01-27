import Foundation
import Combine
import UIKit.UIImage

final class PhotosUseCase {
  private let networkService: NetworkService
  private let imageLoaderService: ImageLoaderService
  
  init(
    networkService: NetworkService,
    imageLoaderService: ImageLoaderService
  ) {
    self.networkService = networkService
    self.imageLoaderService = imageLoaderService
  }
  
  func fetchCuratedPhotos(
    page: Int,
    perPage: Int
  ) -> AnyPublisher<Result<Photos, Error>, Never> {
    return networkService
      .load(Resource<Photos>.curatedPhotos(page: page, perPage: perPage))
      .map({ .success($0) })
      .catch({ error -> AnyPublisher<Result<Photos, Error>, Never> in
        Just(.failure(error))
          .eraseToAnyPublisher()
      })
        .subscribe(on: Scheduler.backgroundWorkScheduler)
        .receive(on: Scheduler.mainScheduler)
        .eraseToAnyPublisher()
  }
  
  func loadImage(
    for photo: Photo,
    sizedURL: String?
  ) -> AnyPublisher<UIImage?, Never> {
    return Deferred { return Just(sizedURL) }
    .flatMap({[unowned self] sizedPhoto -> AnyPublisher<UIImage?, Never> in
      guard let sizedPhoto = sizedURL,
            let url = URL(string: sizedPhoto) else {
        return Just(nil).eraseToAnyPublisher()
      }
      
      return self.imageLoaderService.loadImage(from: url)
    })
    .subscribe(on: Scheduler.backgroundWorkScheduler)
    .receive(on: Scheduler.mainScheduler)
    .share()
    .eraseToAnyPublisher()
  }
}
