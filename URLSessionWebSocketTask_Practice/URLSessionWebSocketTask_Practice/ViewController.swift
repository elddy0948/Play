import UIKit

class ViewController: UIViewController {

  lazy var infoView: InfoView = InfoView()
  lazy var statusView: StatusView = StatusView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    setupStatusView()
    setupInfoView()
    layout()
  }
}

extension ViewController: StatusViewDelegate {
  func connectButtonTapped(_ view: StatusView, connectButton: UIButton) {
    
  }
}

extension ViewController {
  private func setupInfoView() {
    view.addSubview(infoView)
    infoView.translatesAutoresizingMaskIntoConstraints = false
  }
  
  private func setupStatusView() {
    view.addSubview(statusView)
    statusView.translatesAutoresizingMaskIntoConstraints = false
    
    statusView.delegate = self
  }
  
  private func layout() {
    let safeAreaLayoutGuide = view.safeAreaLayoutGuide
    let padding: CGFloat = 8
    
    NSLayoutConstraint.activate([
      //Status View
      statusView.topAnchor.constraint(
        equalTo: safeAreaLayoutGuide.topAnchor,
        constant: padding
      ),
      statusView.leadingAnchor.constraint(
        equalTo: safeAreaLayoutGuide.leadingAnchor,
        constant: padding
      ),
      statusView.trailingAnchor.constraint(
        equalTo: safeAreaLayoutGuide.trailingAnchor,
        constant: -padding
      ),
      infoView.topAnchor.constraint(
        equalTo: statusView.bottomAnchor
      ),
      infoView.leadingAnchor.constraint(
        equalTo: safeAreaLayoutGuide.leadingAnchor
      ),
      infoView.trailingAnchor.constraint(
        equalTo: safeAreaLayoutGuide.trailingAnchor
      ),
    ])
  }
}
