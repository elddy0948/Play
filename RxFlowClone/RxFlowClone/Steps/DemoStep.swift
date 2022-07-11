import Foundation

enum DemoStep: Step {
  case apiKey
  case apiKeyIsComplete
  
  case movieList
  
  case moviePicked(withMovieId: Int)
  case castPicked(withCastId: Int)
  
  case settings
  case settingsDone
  case about  
}
