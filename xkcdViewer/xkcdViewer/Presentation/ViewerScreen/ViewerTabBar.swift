import UIKit

final class ViewerTabBar: UIView {
  private let nextButton = UIButton(type: .system)
  private let prevButton = UIButton(type: .system)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .systemBlue
    
    setupSubViews()
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // TODO: - notch가 있을 때 없을 때 tabbar의 높이 설정
}

extension ViewerTabBar {
  private func setupSubViews() {
    let forwardImage = UIImage(systemName: "forward.fill")
    let backwardImage = UIImage(systemName: "backward.fill")
    
    nextButton.backgroundColor = nil
    nextButton.setImage(forwardImage, for: .normal)
    nextButton.tintColor = .label
    
    prevButton.backgroundColor = nil
    prevButton.setImage(backwardImage, for: .normal)
    prevButton.tintColor = .label
  }
  
  private func layout() {
    nextButton.translatesAutoresizingMaskIntoConstraints = false
    prevButton.translatesAutoresizingMaskIntoConstraints = false
    
    addSubview(nextButton)
    addSubview(prevButton)
    
    NSLayoutConstraint.activate([
      nextButton.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
      trailingAnchor.constraint(equalToSystemSpacingAfter: nextButton.trailingAnchor, multiplier: 1),
      nextButton.widthAnchor.constraint(equalToConstant: 32),
      nextButton.heightAnchor.constraint(equalToConstant: 32),
      
      prevButton.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
      nextButton.leadingAnchor.constraint(equalToSystemSpacingAfter: prevButton.trailingAnchor, multiplier: 2),
      prevButton.widthAnchor.constraint(equalToConstant: 32),
      prevButton.heightAnchor.constraint(equalToConstant: 32),
    ])
  }
}
