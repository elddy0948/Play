//
//  ViewController.swift
//  GithubFollowersMVVM
//
//  Created by 김호준 on 2022/03/12.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemOrange
    let usecase: SearchFollowersUseCase = DefaultSearchFollowersUseCase(
      followersRepository: DefaultFollowersRepository(
        urlString: "https://api.github.com/users"
      )
    )
    
    usecase.execute(
      username: "elddy0948",
      completion: { result in
        switch result {
        case .success(let followers):
          print(followers)
        case .failure(let error):
          print(error)
        }
      })
  }
  
  
}

