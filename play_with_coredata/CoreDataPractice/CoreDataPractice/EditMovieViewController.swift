import UIKit

final class EditMovieViewController: UIViewController {
  private let textField = UITextField()
  private let saveButton = UIButton(type: .system)
  
  private let movie: Movie
  private let storageProvider: StorageProvider
  
  init(movie: Movie, storageProvider: StorageProvider) {
    self.movie = movie
    self.storageProvider = storageProvider
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    style()
    layout()
  }
  
  @objc func didTappedSave() {
    guard let editedName = textField.text else { return }
    movie.name = editedName
    storageProvider.updateMovie()
    self.dismiss(animated: true)
  }
}

extension EditMovieViewController {
  func style() {
    view.backgroundColor = .systemBackground
    textField.layer.borderColor = UIColor.label.cgColor
    textField.layer.borderWidth = 1
    textField.layer.cornerRadius = 8
    textField.layer.masksToBounds = true
    textField.text = movie.name
    
    textField.backgroundColor = .systemBackground
    textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
    textField.leftViewMode = .always
    
    saveButton.backgroundColor = .link
    saveButton.layer.cornerRadius = 8
    saveButton.layer.masksToBounds = true
    saveButton.setTitle(" Save ", for: .normal)
    saveButton.setTitleColor(.white, for: .normal)
    saveButton.addTarget(self, action: #selector(didTappedSave), for: .touchUpInside)
  }
  
  func layout() {
    textField.translatesAutoresizingMaskIntoConstraints = false
    saveButton.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(textField)
    view.addSubview(saveButton)
    
    NSLayoutConstraint.activate([
      textField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
      textField.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
      textField.leadingAnchor.constraint(
        equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor,
        multiplier: 1
      ),
      view.safeAreaLayoutGuide.trailingAnchor.constraint(
        equalToSystemSpacingAfter: textField.trailingAnchor, multiplier: 1
      ),
      textField.heightAnchor.constraint(equalToConstant: 32),
      saveButton.topAnchor.constraint(
        equalToSystemSpacingBelow: textField.bottomAnchor,
        multiplier: 1
      ),
      saveButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
      saveButton.heightAnchor.constraint(equalToConstant: 32),
    ])
  }
}
