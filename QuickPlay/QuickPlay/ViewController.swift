//
//  ViewController.swift
//  QuickPlay
//
//  Created by 김호준 on 2021/12/20.
//

import UIKit

class ViewController: UITableViewController {
  private lazy var addVideoButton: UIButton = {
    let button = UIButton()
    button.tintColor = .link
    button.setImage(
      UIImage(
        systemName: "video.badge.plus"
      ),
      for: .normal
    )
    return button
  }()
  
  let reuseId = "CellId"
  var isPresented: Bool = false
  var videos: [URL] = [] {
    didSet {
      tableView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    tableView.register(
      UITableViewCell.self,
      forCellReuseIdentifier: reuseId
    )
    setupButton()
    layout()
  }
}

//MARK: - Actions
extension ViewController {
  @objc func didTappedAddVideoButton(_ sender: UIButton) {
    setupPHPickerViewController()
  }
}

//MARK: - UI
extension ViewController {
  private func setupButton() {
    view.addSubview(addVideoButton)
    addVideoButton.translatesAutoresizingMaskIntoConstraints = false
    addVideoButton.addTarget(
      self,
      action: #selector(didTappedAddVideoButton(_:)),
      for: .touchUpInside
    )
  }
  
  private func layout() {
    let safeAreaLayoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      addVideoButton.bottomAnchor.constraint(
        equalTo: safeAreaLayoutGuide.bottomAnchor,
        constant: -16
      ),
      addVideoButton.leadingAnchor.constraint(
        equalTo: safeAreaLayoutGuide.leadingAnchor,
        constant: 16
      ),
      addVideoButton.heightAnchor.constraint(
        equalToConstant: 50
      ),
      addVideoButton.widthAnchor.constraint(
        equalToConstant: 50
      ),
    ])
  }
}

