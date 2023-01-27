import Foundation

// provides Network service and ImageLoader service
final class ServiceProvider {
  let network: NetworkService
  let imageLoader: ImageLoaderService
  
  static func defaultProvider() -> ServiceProvider {
    let networkService = NetworkService()
    let imageLoader = ImageLoaderService()
    return ServiceProvider(
      network: networkService,
      imageLoader: imageLoader)
  }
  
  init(
    network: NetworkService,
    imageLoader: ImageLoaderService
  ) {
    self.network = network
    self.imageLoader = imageLoader
  }
}
