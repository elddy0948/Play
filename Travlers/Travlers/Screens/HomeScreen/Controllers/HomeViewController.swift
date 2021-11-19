//
//  HomeViewController.swift
//  Travlers
//
//  Created by 김호준 on 2021/11/19.
//

import UIKit

class HomeViewController: UIViewController {
  
  private let storyView = StoryView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    setupStoryView()
  }
  
  private func setupStoryView() {
    view.addSubview(storyView)
    storyView.translatesAutoresizingMaskIntoConstraints = false
    
    let safeAreaLayoutGuide = view.safeAreaLayoutGuide
    let storyViewHeight = view.frame.height / 10
    
    NSLayoutConstraint.activate([
      storyView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      storyView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      storyView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      storyView.heightAnchor.constraint(equalToConstant: storyViewHeight),
    ])
  }
}
