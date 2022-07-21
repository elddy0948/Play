import UIKit

final class OnboardingViewController: UIViewController {
  let stackView = UIStackView()
  let imageView = UIImageView()
  let label = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    style()
    layout()
  }
}

extension OnboardingViewController {
  private func style() {
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.alignment = .center
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    imageView.image = UIImage(named: "BlueBall")
    
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Bankey is faster, easier to use, and has a brand new look and feel that will make you feel like you are back in the 80s."
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
