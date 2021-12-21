//
//  ViewController.swift
//  QuickPlay
//
//  Created by 김호준 on 2021/12/20.
//

import UIKit
import AVKit

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
  
  private lazy var playAllButton: UIButton = {
    let button = UIButton()
    button.tintColor = .link
    button.setImage(
      UIImage(
        systemName: "list.and.film"
      ),
      for: .normal
    )
    return button
  }()
  
  var avPlayer: AVPlayer?
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
      VideoTableViewCell.self,
      forCellReuseIdentifier: VideoTableViewCell.reuseIdentifier
    )
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 100.0
    setupButton()
    setupPlayAllButton()
    layout()
  }
}

//MARK: - Actions
extension ViewController {
  @objc func didTappedAddVideoButton(_ sender: UIButton) {
    setupPHPickerViewController()
  }
  
  @objc func didTappedPlayAllButton(_ sender: UIButton) {
    let playerItems = videos.map({ url in
      AVPlayerItem(url: url)
    })
    let player = AVQueuePlayer(items: playerItems)
    let vc = AVPlayerViewController()
    vc.player = player
    vc.requiresLinearPlayback = true
    vc.showsPlaybackControls = true
    present(
      vc,
      animated: true,
      completion: nil
    )
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
  
  private func setupPlayAllButton() {
    view.addSubview(playAllButton)
    playAllButton.translatesAutoresizingMaskIntoConstraints = false
    playAllButton.addTarget(
      self,
      action: #selector(didTappedPlayAllButton(_:)),
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
      playAllButton.trailingAnchor.constraint(
        equalTo: safeAreaLayoutGuide.trailingAnchor,
        constant: -16
      ),
      playAllButton.bottomAnchor.constraint(
        equalTo: safeAreaLayoutGuide.bottomAnchor,
        constant: -16
      ),
    ])
  }
}

