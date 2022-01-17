import UIKit

class ViewController: UIViewController {

  lazy var infoView: InfoView = InfoView()
  lazy var statusView: StatusView = StatusView()
  let networkingAPI = NetworkingAPI.shared
  var webSocketTask: URLSessionWebSocketTask?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    setupStatusView()
    setupInfoView()
    layout()
  }
  
  
  func createReceiveCompletionHandler() {
    guard let webSocketTask = webSocketTask else {
      return
    }
    
    webSocketTask.receive(completionHandler: { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let message):
        self.statusView.changeStatus()
        switch message {
        case .string(let string):
          print(string)
        case .data(let data):
          print(data)
        @unknown default:
          fatalError("Error!")
        }
      case .failure(let error):
        print(error.localizedDescription)
      }
    })
  }
}

extension ViewController: StatusViewDelegate {
  func connectButtonTapped(_ view: StatusView, connectButton: UIButton) {
    guard let url = URL(string: "wss://pubwss.bithumb.com/pub/ws") else {
      return
    }
    webSocketTask = networkingAPI.createSession(url: url)
    createReceiveCompletionHandler()
    guard let webSocketTask = webSocketTask else { return }
    webSocketTask.resume()
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
