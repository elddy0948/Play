import Foundation
import UIKit.UIImage
import Combine

final class ImageLoaderService {
  private let cache = ImageCache()
  
  func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
    if let image = cache.image(for: url) {
      return Just(image).eraseToAnyPublisher()
    }
    
    return URLSession.shared
      .dataTaskPublisher(for: url)
      .map({ data, response -> UIImage? in
        return UIImage(data: data)
      }).catch({ error in
        return Just(nil)
      }).handleEvents(receiveOutput: { [unowned self] image in
        guard let image = image else{ return }
        self.cache.insertImage(image, for: url)
      }).print("Image loading \(url) : ")
        .eraseToAnyPublisher()
  }
}
