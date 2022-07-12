import Foundation

enum DemoStep: Step {
  case apiKey
  case apiKeyIsComplete
  
  case home
  case splash
  
  case articleList
  case articlePicked(article: Article)
  
  case settings
  case settingsDone
  case about
}
