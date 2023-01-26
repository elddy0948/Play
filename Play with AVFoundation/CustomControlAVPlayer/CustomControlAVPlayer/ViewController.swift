import AVFoundation
import AVKit
import UIKit

class ViewController: UIViewController {
  var playPauseButton: PlayPauseButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    guard let url = URL(string: "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8") else { return }
    
    let player = AVPlayer(url: url)
    player.rate = 1
    
    let playerFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    let playerViewController = AVPlayerViewController()
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedPlayerView))
    
    playerViewController.player = player
    playerViewController.view.frame = playerFrame
    playerViewController.showsPlaybackControls = false // 기본 제공되는 Playback Control 제거
    playerViewController.view.addGestureRecognizer(tapGesture)
    
    addChild(playerViewController)
    view.addSubview(playerViewController.view)
    playerViewController.didMove(toParent: self)
    
    playPauseButton = PlayPauseButton()
    playPauseButton.avPlayer = player
    view.addSubview(playPauseButton)
    playPauseButton.setup(in: self)
    playPauseButton.visible = true
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    playPauseButton.updateUI()
  }
  
  @objc func tappedPlayerView() {
    playPauseButton.visible.toggle()
  }
}

