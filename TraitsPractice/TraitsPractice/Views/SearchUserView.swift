import UIKit


class SearchUserView: UIView {
  
  //MARK: - Views
  lazy var searchTextField: UITextField = {
    let textField = UITextField()
    textField.leftView = UIView(
      frame: CGRect(
        x: 0, y: 0,
        width: 10, height: 0
      )
    )
    textField.leftViewMode = .always
    textField.borderStyle = .line
    textField.autocorrectionType = .no
    textField.autocapitalizationType = .none
    return textField
  }()
  
  lazy var searchButton: UIButton = {
    let button = UIButton()
    button.setTitle("Search", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = .systemPurple
    button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupSearchTextField()
    setupSearchButton()
    layout()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupSearchTextField()
    setupSearchButton()
    layout()
  }
  
  @objc func searchButtonDidTapped(_ sender: UIButton) {
    
  }
}

extension SearchUserView {
  
  private func setupSearchTextField() {
    addSubview(searchTextField)
    searchTextField.translatesAutoresizingMaskIntoConstraints = false
  }
  
  
  private func setupSearchButton() {
    addSubview(searchButton)
    searchButton.translatesAutoresizingMaskIntoConstraints = false
    
    searchButton.layer.cornerRadius = 8
    searchButton.layer.masksToBounds = false
    
    searchButton.addTarget(
      self,
      action: #selector(searchButtonDidTapped(_:)),
      for: .touchUpInside
    )
  }
  
  private func layout() {
    NSLayoutConstraint.activate([
      searchTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
      searchTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
      searchTextField.leadingAnchor.constraint(
        equalTo: leadingAnchor,
        constant: 8
      ),
      searchTextField.trailingAnchor.constraint(
        equalTo: trailingAnchor,
        constant: -8
      ),
      
      //Button
      searchButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      searchButton.topAnchor.constraint(
        equalTo: searchTextField.bottomAnchor,
        constant: 8
      ),
      searchButton.heightAnchor.constraint(equalToConstant: 32),
    ])
  }
}
