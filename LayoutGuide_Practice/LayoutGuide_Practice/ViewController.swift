//
//  ViewController.swift
//  LayoutGuide_Practice
//
//  Created by 김호준 on 2021/11/23.
//

import UIKit

class ViewController: UIViewController {
  
  private lazy var redView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemRed
    return view
  }()
  
  private lazy var blueView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemBlue
    return view
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    
    setupLayoutGuide()
  }
  
  private func setupLayoutGuide() {
    let redContainer = UILayoutGuide()
    let blueContainer = UILayoutGuide()
    
    view.addSubview(redView)
    redView.addSubview(blueView)
    
    view.addLayoutGuide(redContainer)
    redView.addLayoutGuide(blueContainer)
    
    redView.translatesAutoresizingMaskIntoConstraints = false
    blueView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      //Red View
      redView.topAnchor.constraint(equalTo: redContainer.topAnchor),
      redView.leadingAnchor.constraint(equalTo: redContainer.leadingAnchor),
      redView.trailingAnchor.constraint(equalTo: redContainer.trailingAnchor),
      redView.bottomAnchor.constraint(equalTo: redContainer.bottomAnchor),
      
      //Blue View
      blueView.topAnchor.constraint(equalTo: blueContainer.topAnchor),
      blueView.leadingAnchor.constraint(equalTo: blueContainer.leadingAnchor),
      blueView.trailingAnchor.constraint(equalTo: blueContainer.trailingAnchor),
      blueView.bottomAnchor.constraint(equalTo: blueContainer.bottomAnchor),
    ])
    
    let safeAreaLayoutGuide = view.safeAreaLayoutGuide
    
    NSLayoutConstraint.activate([
      //Container
      redContainer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,
                                    constant: 20),
      redContainer.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                                        constant: 50),
      redContainer.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                                         constant: -50),
      redContainer.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                       constant: -20),
    ])
    
    let margins = redView.layoutMarginsGuide
    
    NSLayoutConstraint.activate([
      blueContainer.topAnchor.constraint(equalTo: margins.topAnchor),
      blueContainer.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
      blueContainer.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
      blueContainer.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
    ])

  }
}

