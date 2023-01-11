import UIKit

class ViewController: UIViewController {
  private let movieNameTextField = UITextField()
  private let saveButton = UIButton(type: .system)
  
  //MARK: - Properties
  private let storageProvider: StorageProvider
  
  //MARK: - Initializer
  init(storageProvider: StorageProvider) {
    self.storageProvider = storageProvider
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    
    style()
    layout()
  }
  
  @objc func didTappedSaveButton() {
    // Do Something
    guard let movieName = movieNameTextField.text else {
      return
    }
    
    storageProvider.saveMovie(named: movieName)
  }
}

extension ViewController {
  private func style() {
    movieNameTextField.autocorrectionType = .no
    movieNameTextField.autocapitalizationType = .none
    movieNameTextField.textColor = .label
    movieNameTextField.layer.cornerRadius = 8
    movieNameTextField.layer.borderColor = UIColor.secondaryLabel.cgColor
    movieNameTextField.layer.borderWidth = 1
    movieNameTextField.backgroundColor = .systemBackground
    movieNameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
    movieNameTextField.leftViewMode = .always
    
    saveButton.backgroundColor = .link
    saveButton.setTitleColor(.white, for: .normal)
    saveButton.setTitle("  Save  ", for: .normal)
    saveButton.layer.cornerRadius = 8
    saveButton.addTarget(self, action: #selector(didTappedSaveButton), for: .touchUpInside)
  }
  
  private func layout() {
    movieNameTextField.translatesAutoresizingMaskIntoConstraints = false
    saveButton.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(movieNameTextField)
    view.addSubview(saveButton)
    
    NSLayoutConstraint.activate([
      movieNameTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
      movieNameTextField.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
      movieNameTextField.heightAnchor.constraint(equalToConstant: 48),
      movieNameTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
      view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: movieNameTextField.trailingAnchor, multiplier: 1),
      
      saveButton.topAnchor.constraint(equalToSystemSpacingBelow: movieNameTextField.bottomAnchor, multiplier: 1),
      saveButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
      saveButton.heightAnchor.constraint(equalToConstant: 32),
    ])
    
  }
}

