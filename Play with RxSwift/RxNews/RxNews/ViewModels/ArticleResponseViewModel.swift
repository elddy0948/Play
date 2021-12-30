import Foundation
import RxSwift


class ArticleResponseViewModel {
  private let articleService: ArticleService
  
  init() {
    articleService = ArticleService.shared
  }
  
  func fetchArticleResponse() -> Observable<[ArticleViewModel]> {
    articleService.fetchArticles()
      .map({ articleResponse -> [Article] in
        return articleResponse.articles
      })
      .map({ articles in
        articles.map({ article in
          let articleViewModel = ArticleViewModel(article: article)
          return articleViewModel
        })
      })
  }
}
