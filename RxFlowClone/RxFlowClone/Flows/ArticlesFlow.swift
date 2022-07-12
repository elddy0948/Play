import UIKit
import RxSwift

class ArticlesFlow: Flow {
  var root: Presentable {
    return self.rootViewController
  }
  
  private var rootViewController = UINavigationController()
  
  func navigate(to step: Step) -> FlowContributors {
    guard let step = step as? DemoStep else { return .none }
    
    switch step {
    case .articleList:
      return navigationToArticleList()
    case .articlePicked(let article):
      return navigationToArticleDetail(article: article)
    default:
      return .none
    }
  }
  
  private func navigationToArticleList() -> FlowContributors {
    
  }
  
  private func navigationToArticleDetail(article: Article) -> FlowContributors {
    
  }
}
