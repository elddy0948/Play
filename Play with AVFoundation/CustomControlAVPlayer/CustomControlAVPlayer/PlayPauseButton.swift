import UIKit
import AVKit
import AVFoundation

final class PlayPauseButton: UIView {
  
  var kvoRateContext = 0
  var avPlayer: AVPlayer?
  var isPlaying: Bool {
    return avPlayer?.rate != 0 && avPlayer?.error == nil
  }
  var visible: Bool = false {
    didSet {
      if visible { setViewAlpha(to: 1.0) }
      else { setViewAlpha(to: 0.0) }
    }
  }
  
  //MARK: - Override
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    guard let context = context else { return }
    switch context {
    case &kvoRateContext:
      handleRateChanged()
    default:
      break
    }
  }
  
  func addObservers() {
    avPlayer?.addObserver(self, forKeyPath: "rate", options: .new, context: &kvoRateContext)
  }
  
  func setup(in container: UIViewController) {
    let gesture = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
    addGestureRecognizer(gesture)
    
    updatePosition()
    updateUI()
    addObservers()
  }
  
  func updateUI() {
    isPlaying ? setBackgroundImage(name: "pause.fill") : setBackgroundImage(name: "play.fill")
  }
  
  //MARK: - Private
  private func updateStatus() {
    isPlaying ? avPlayer?.pause() : avPlayer?.play()
  }
  
  private func updatePosition() {
    guard let superview = superview else { return }
    translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      widthAnchor.constraint(equalToConstant: 80),
      heightAnchor.constraint(equalToConstant: 80),
      centerXAnchor.constraint(equalTo: superview.centerXAnchor),
      centerYAnchor.constraint(equalTo: superview.centerYAnchor),
    ])
  }
  
  private func setBackgroundImage(name: String) {
    UIGraphicsBeginImageContext(frame.size)
    UIImage(systemName: name)?.draw(in: bounds)
    guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return }
    UIGraphicsEndImageContext()
    backgroundColor = UIColor(patternImage: image)
  }
  
  private func handleRateChanged() {
    updateUI()
  }
  
  private func setViewAlpha(to amount: CGFloat) {
    UIView.animate(withDuration: 0.2, animations: {
      self.alpha = amount
    })
  }
  
  //MARK: - Actions
  @objc private func tapped(_ sender: UITapGestureRecognizer) {
    updateStatus()
    updateUI()
  }
}
