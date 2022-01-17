import UIKit

protocol StatusViewDelegate: AnyObject {
  func connectButtonTapped(_ view: StatusView, connectButton: UIButton)
  func sendButtonTapped(_ view: StatusView)
}

final class StatusView: UIStackView {
  lazy var connectButton: UIButton = {
    let button = UIButton()
    button.setTitle("Connect!", for: .normal)
    button.setTitleColor(.link, for: .normal)
    return button
  }()
  
  lazy var connectionStatusLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.font = .preferredFont(forTextStyle: .body)
    label.textColor = .label
    label.text = "Status: Disconnected"
    return label
  }()
  
  lazy var sendButton: UIButton = {
    let button = UIButton()
    button.setTitle("Send", for: .normal)
    button.setTitleColor(.systemBrown, for: .normal)
    return button
  }()
  
  weak var delegate: StatusViewDelegate?
  private var connectionStatus: Bool = false {
    didSet {
      DispatchQueue.main.async { [weak self] in
        guard let self = self else { return }
        self.connectionStatus ?
        (self.connectionStatusLabel.text = "Status: Connected") :
        (self.connectionStatusLabel.text = "Status : Disconnected")
      }
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupStackView()
    setupSubViews()
  }
  
  required init(coder: NSCoder) {
    super.init(coder: coder)
    setupStackView()
    setupSubViews()
  }
  
  func changeStatus() {
    connectionStatus.toggle()
  }
  
  @objc func didTappedConnectButton(_ sender: UIButton) {
    delegate?.connectButtonTapped(self, connectButton: sender)
  }
  
  @objc func didTappedSendButton(_ sender: UIButton) {
    delegate?.sendButtonTapped(self)
  }
}

extension StatusView {
  
  private func setupStackView() {
    axis = .horizontal
    distribution = .fill
    spacing = 8
    backgroundColor = .systemBackground
  }
  
  private func setupSubViews() {
    addArrangedSubview(connectButton)
    addArrangedSubview(connectionStatusLabel)
    addArrangedSubview(sendButton)
    
    connectButton.addTarget(
      self,
      action: #selector(didTappedConnectButton(_:)),
      for: .touchUpInside
    )
    
    sendButton.addTarget(
      self,
      action: #selector(didTappedSendButton(_:)),
      for: .touchUpInside
    )
    
    connectButton.setContentHuggingPriority(
      UILayoutPriority(251),
      for: .horizontal
    )
    
    sendButton.setContentHuggingPriority(
      UILayoutPriority(251),
      for: .horizontal
    )
    
    connectionStatusLabel.setContentHuggingPriority(
      UILayoutPriority(252),
      for: .horizontal
    )
  }
}
