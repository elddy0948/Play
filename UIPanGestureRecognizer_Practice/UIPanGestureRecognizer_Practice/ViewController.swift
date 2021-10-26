import UIKit

class ViewController: UIViewController {

  var movableView = UIView()
  var panGestureRecognizer: UIPanGestureRecognizer!
  
  var centerWhenBegan = CGPoint()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    configureGestureRecognizer()
    configureView()
    layout()
  }
  
  //Pan Gesture Recognizer 정의
  private func configureGestureRecognizer() {
    panGestureRecognizer = UIPanGestureRecognizer()
    panGestureRecognizer.addTarget(self, action: #selector(handlePanGestureRecognizer(_:)))
  }

  private func configureView() {
    movableView = UIView()
    view.addSubview(movableView)
    
    movableView.translatesAutoresizingMaskIntoConstraints = false
    movableView.backgroundColor = .systemGreen
    movableView.addGestureRecognizer(panGestureRecognizer) //Gesture Recognizer 추가
  }
  
  //Gesture Recognizer Action
  @objc func handlePanGestureRecognizer(_ recognizer: UIPanGestureRecognizer) {
    guard let movableView = recognizer.view else { return }
    
    let translation = recognizer.translation(in: movableView.superview)
    
    switch recognizer.state {
    case .began:
      self.centerWhenBegan = movableView.center
    case .changed:
      let newCenter = CGPoint(x: centerWhenBegan.x + translation.x, y: centerWhenBegan.y + translation.y)
      movableView.center = newCenter //Move View!!
    case .ended:
      print("Ended!")
    default:
      print("Default!")
    }
  }
}

extension ViewController {
  private func layout() {
    NSLayoutConstraint.activate([
      movableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      movableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      movableView.heightAnchor.constraint(equalToConstant: 100),
      movableView.widthAnchor.constraint(equalToConstant: 100),
    ])
  }
}
