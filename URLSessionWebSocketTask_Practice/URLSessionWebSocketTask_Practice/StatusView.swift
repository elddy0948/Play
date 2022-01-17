import UIKit

protocol StatusViewDelegate: AnyObject {
  func connectButtonTapped(_ view: StatusView, connectButton: UIButton)
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
  
  weak var delegate: StatusViewDelegate?
  
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
  
  @objc func didTappedConnectButton(_ sender: UIButton) {
    delegate?.connectButtonTapped(self, connectButton: sender)
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
    
    connectButton.addTarget(
      self,
      action: #selector(didTappedConnectButton(_:)),
      for: .touchUpInside
    )
    
    connectButton.setContentHuggingPriority(
      UILayoutPriority(251),
      for: .horizontal
    )
    
    connectionStatusLabel.setContentHuggingPriority(
      UILayoutPriority(252),
      for: .horizontal
    )
  }
}
