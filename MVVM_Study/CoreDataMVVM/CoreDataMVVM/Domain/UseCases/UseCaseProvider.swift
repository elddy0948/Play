//
//  UseCaseProvider.swift
//  CoreDataMVVM
//
//  Created by 김호준 on 2022/05/16.
//

import Foundation

protocol UseCaseProvider {
  func makePostsUseCase() -> PostsUseCase
}
