import RxSwift
import RxRelay

class WatchedViewModel: Stepper {
  let steps = PublishRelay<Step>()
  
  // MovieViewModel Array
  
  init() {
    //initialize service
  }
  
  func pick(movieID: Int) {
    self.steps.accept(DemoStep.moviePicked(withMovieId: movieID))
  }
}
