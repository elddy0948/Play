import RxFlow

enum ExampleStep: Step {
  case launchIsRequired
  
  case mainIsRequired
  
  case homeIsRequired
  case mypageIsRequired
  
  case homeNext
  case mypageNext
}
