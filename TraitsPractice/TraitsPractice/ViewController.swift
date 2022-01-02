//
//  ViewController.swift
//  TraitsPractice
//
//  Created by 김호준 on 2021/12/30.
//

import UIKit

class ViewController: UIViewController {

  lazy var searchUserView: SearchUserView = SearchUserView()
  
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

