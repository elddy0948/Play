import Foundation

final class DefaultXkcdRepository {
  @Published var xkcd: Xkcd?
  
  private let dataTransferService: NetworkService
  
  init(xkcd: Xkcd? = nil, dataTransferService: NetworkService) {
    self.xkcd = xkcd
    self.dataTransferService = dataTransferService
  }
  
  func fetchData(num: Int) async {
    Task {
      await dataTransferService.fetch(num: 1)
    }
  }
}
