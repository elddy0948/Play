//
//  ArticleViewModel.swift
//  RxNews
//
//  Created by 김호준 on 2021/11/27.
//

import Foundation


struct ArticleViewModel {
  private let article: Article
  
  var title: String {
    return article.title
  }
  
  var description: String {
    return article.description
  }
  
  var author: String? {
    return article.author
  }
  
  var imageUrl: String? {
    return article.urlToImage
  }
  
  init(article: Article) {
    self.article = article
  }
}
