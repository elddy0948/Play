import Combine
import Foundation
import UIKit.UIImage

struct PhotoCellViewModelBuilder {
  static func createViewModel(from photo: Photo, imageLoader: (Photo) -> AnyPublisher<UIImage?, Never>) -> PhotoCellViewModel {
    return PhotoCellViewModel(
      id: photo.id,
      width: photo.width,
      height: photo.height,
      url: photo.url,
      photographer: photo.photographer,
      photographerURL: photo.photographerURL,
      photographerID: photo.photographerID,
      avgColor: photo.avgColor,
      image: imageLoader(photo),
      alt: photo.alt)
  }
}
