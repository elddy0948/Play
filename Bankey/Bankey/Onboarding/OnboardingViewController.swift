import UIKit

final class OnboardingViewController: UIViewController {
  let stackView = UIStackView()
  let imageView = UIImageView()
  let label = UILabel()
  
  private let imageName: String
  private let titleText: String
  
  override func viewDidLoad() {
    super.viewDidLoad()
    style()
    layout()
  }
  
  init(imageName: String, titleText: String) {
    self.imageName = imageName
    self.titleText = titleText
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    self.imageName = ""
    self.titleText = ""
    
    super.init(coder: coder)
  }
}

extension OnboardingViewController {
  private func style() {
    view.backgroundColor = .systemBackground
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.alignment = .center
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    imageView.image = UIImage(named: imageName)
    
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = titleText
    label.numberOfLines = 0
    label.font = .preferredFont(forTextStyle: .title3)
    label.textColor = .label
    label.textAlignment = .center
  }
  
  private func layout() {
    view.addSubview(stackView)
    stackView.addArrangedSubview(imageView)
    stackView.addArrangedSubview(label)
    
    NSLayoutConstraint.activate([
      stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
      stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
      stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
      view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
    ])
  }
}
