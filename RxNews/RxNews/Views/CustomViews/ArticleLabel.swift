//
//  ArticleLabel.swift
//  RxNews
//
//  Created by 김호준 on 2021/11/27.
//

import UIKit

class ArticleLabel: UILabel {

  init(textStyle: UIFont.TextStyle) {
    super.init(frame: .zero)
    setupArticleLabel(textStyle: textStyle)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  private func setupArticleLabel(textStyle: UIFont.TextStyle) {
    font = UIFont.preferredFont(forTextStyle: textStyle)
    textColor = .label
    textAlignment = .left
    numberOfLines = 0
  }
}
