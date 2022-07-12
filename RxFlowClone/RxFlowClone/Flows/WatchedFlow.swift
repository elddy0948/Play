import UIKit

class WatchedFlow: Flow {
  var root: Presentable {
    return self.rootViewController
  }
  
  private let rootViewController = UINavigationController()
//  private let service: MoviesService
//
//  init(withService service: MoviesService) {
//    self.service = service
//  }
  init() {
    
  }
  
  func navigate(to step: Step) -> FlowContributors {
    guard let step = step as? DemoStep else {
      return FlowContributors.none
    }
    
    switch step {
    case .movieList:
      return navigateToMovieListScreen()
    case .moviePicked(let movieID):
      return navigateToMovieDetailScreen(with: movieID)
    case .castPicked(let castID):
      return navigateToCastDetailScreen(with: castID)
    default:
      return FlowContributors.none
    }
  }
  
  private func navigateToMovieListScreen() -> FlowContributors {
    
  }
  
  private func navigateToMovieDetailScreen(with movieID: Int) -> FlowContributors {
  }
  
  private func navigateToCastDetailScreen(with castID: Int) -> FlowContributors {
    
  }
}
