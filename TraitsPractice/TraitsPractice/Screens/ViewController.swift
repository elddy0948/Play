//
//  ViewController.swift
//  TraitsPractice
//
//  Created by 김호준 on 2021/12/30.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

  lazy var searchUserView: SearchUserView = SearchUserView()
  private let bag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemBackground
    setupSearchUserView()
    layout()
  }
}

extension ViewController {
  private func setupSearchUserView() {
    view.addSubview(searchUserView)
    searchUserView.translatesAutoresizingMaskIntoConstraints = false
    searchUserView.delegate = self
  }
  
  private func layout() {
    let safeAreaLayoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      searchUserView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      searchUserView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      searchUserView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      searchUserView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
    ])
  }
}

extension ViewController: SearchUserViewDelegate {
  func searchUserView(_ view: SearchUserView, search username: String) {
    UserNetworkingAPI.shared.fetchUserInfo(with: username)
      .observe(on: MainScheduler.instance)
      .subscribe(
        onSuccess: { [weak self] user in
          self?.showUserDetailScreen(with: user)
        },
        onFailure: { error in
          print(error)
        },
        onDisposed: { }
      )
      .disposed(by: bag)
  }
  
  private func showUserDetailScreen(with user: User) {
    let viewController = UserDetailViewController(user: user)
    navigationController?.pushViewController(
      viewController,
      animated: true
    )
  }
}
