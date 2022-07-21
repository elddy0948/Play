//
//  ViewController.swift
//  ScrollViewLayoutGuides
//
//  Created by 김호준 on 2021/11/19.
//

import UIKit

class ViewController: UIViewController {
  
  private let redView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemRed
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private let blueView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemBlue
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private let greenView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemGreen
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.distribution = .fill
    return stackView
  }()
  
  private let scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    return scrollView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    
    configureScrollView()
    configureStackView()
  }
  
  private func configureScrollView() {
    view.addSubview(scrollView)
    
    let frameLayoutGuide = scrollView.frameLayoutGuide
    
    NSLayoutConstraint.activate([
      frameLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      frameLayoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      frameLayoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      frameLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
    ])
  }
  
  private func configureStackView() {
    scrollView.addSubview(stackView)
    
    stackView.addArrangedSubview(redView)
    redView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    stackView.addArrangedSubview(blueView)
    blueView.heightAnchor.constraint(equalToConstant: 250).isActive = true
    stackView.addArrangedSubview(greenView)
    greenView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    
    let contentLayoutGuide = scrollView.contentLayoutGuide
    
    NSLayoutConstraint.activate([
      stackView.widthAnchor.constraint(equalTo: view.widthAnchor),
      stackView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
      stackView.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor),
      stackView.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor),
    ])
  }
}

