import UIKit

protocol AddTodoViewControllerDelegate: AnyObject {
  func save(_ viewController: UIViewController, item: Item)
}

class AddTodoViewController: UIViewController {
  //MARK: - Views
  lazy var segmentedControl: UISegmentedControl = {
    let segmentedControl = UISegmentedControl(items: ["High", "Medium", "Low"])
    return segmentedControl
  }()
  
  lazy var textField: UITextField = {
    let textField = UITextField()
    textField.leftViewMode = .always
    textField.leftView = UIView()
    textField.autocorrectionType = .no
    textField.autocapitalizationType = .none
    textField.layer.borderWidth = 1.0
    textField.layer.borderColor = UIColor.systemGray.cgColor
    return textField
  }()
  
  //MARK: - Properties
  weak var delegate: AddTodoViewControllerDelegate?
  
  //MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    setupRightBarButton()
    setupSegmentedControl()
    setupTextField()
    layout()
  }
  
  @objc func didTappedSaveButton() {
    let item = Item(
      content: textField.text ?? "No Content",
      priority: Priority(
        rawValue: segmentedControl.selectedSegmentIndex
      ) ?? .high
    )
    
    delegate?.save(self, item: item)
  }
}

//MARK: - UI setup / Layout
extension AddTodoViewController {
  private func setupRightBarButton() {
    let addButton = UIBarButtonItem(
      barButtonSystemItem: .save, target: self,
      action: #selector(didTappedSaveButton)
    )
    
    navigationItem.setRightBarButton(addButton, animated: true)
  }
  
  private func setupSegmentedControl() {
    view.addSubview(segmentedControl)
    segmentedControl.translatesAutoresizingMaskIntoConstraints = false
  }
  
  private func setupTextField() {
    view.addSubview(textField)
    textField.translatesAutoresizingMaskIntoConstraints = false
  }
  
  private func layout() {
    let safeAreaLayoutGuide = view.safeAreaLayoutGuide
    let padding: CGFloat = 8
    
    NSLayoutConstraint.activate([
      segmentedControl.topAnchor.constraint(
        equalTo: safeAreaLayoutGuide.topAnchor,
        constant: padding
      ),
      segmentedControl.centerXAnchor.constraint(
        equalTo: safeAreaLayoutGuide.centerXAnchor
      ),
      textField.centerXAnchor.constraint(
        equalTo: safeAreaLayoutGuide.centerXAnchor
      ),
      textField.centerYAnchor.constraint(
        equalTo: safeAreaLayoutGuide.centerYAnchor
      ),
      textField.leadingAnchor.constraint(
        equalTo: safeAreaLayoutGuide.leadingAnchor,
        constant: padding * 2
      ),
      textField.trailingAnchor.constraint(
        equalTo: safeAreaLayoutGuide.trailingAnchor,
        constant: -(padding * 2)
      )
    ])
  }
}
