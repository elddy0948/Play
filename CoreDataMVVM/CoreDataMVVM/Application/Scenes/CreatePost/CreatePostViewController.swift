import UIKit
import RxSwift

final class CreatePostViewController: UIViewController {
  private lazy var titleTextField: UITextField = {
    let textField = UITextField()
    textField.autocorrectionType = .no
    textField.autocapitalizationType = .none
    textField.font = .preferredFont(forTextStyle: .title1)
    textField.textColor = .label
    textField.layer.borderWidth = 3
    textField.layer.borderColor = UIColor.systemGray.cgColor
    textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
    textField.leftViewMode = .always
    textField.placeholder = "Title..."
    return textField
  }()
  
  private lazy var descriptionTextField: UITextField = {
    let textField = UITextField()
    textField.autocorrectionType = .no
    textField.autocapitalizationType = .none
    textField.font = .preferredFont(forTextStyle: .body)
    textField.textColor = .label
    textField.layer.borderWidth = 3
    textField.layer.borderColor = UIColor.systemGray.cgColor
    textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
    textField.leftViewMode = .always
    textField.placeholder = "Content..."
    return textField
  }()
  
  private let useCaseProvider: UseCaseProvider
  private let viewModel: CreatePostViewModel
  
  private let saveTrigger = PublishSubject<Void>()
  private let titleSubject = BehaviorSubject<String>(value: "")
  private let descriptionsSubject = BehaviorSubject<String>(value: "")
  private let bag = DisposeBag()
  
  init() {
    self.useCaseProvider = CDUseCaseProvider()
    self.viewModel = CreatePostViewModel(createPostUseCase: useCaseProvider.makePostsUseCase())
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    self.useCaseProvider = CDUseCaseProvider()
    self.viewModel = CreatePostViewModel(createPostUseCase: useCaseProvider.makePostsUseCase())
    super.init(coder: coder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bindViewModel()
    configureViewController()
    layout()
  }
  
  private func bindViewModel() {
    let inputs = CreatePostViewModel.Input(
      save: saveTrigger.asObservable(),
      title: titleSubject.asObservable(),
      descriptions: descriptionsSubject.asObservable()
    )
    
    let output = viewModel.transform(inputs)
    output.dismiss
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] _ in
        self?.dismiss(animated: true)
      })
      .disposed(by: bag)
  }
  
  @objc func saveAction(_ sender: UIBarButtonItem) {
    titleSubject.onNext(titleTextField.text ?? "")
    descriptionsSubject.onNext(descriptionTextField.text ?? "")
    saveTrigger.onNext(())
  }
}

//MARK: - UI Setup / Layout
extension CreatePostViewController {
  private func configureViewController() {
    title = "Create Post"
    view.backgroundColor = .systemBackground
    let rightBarButton = UIBarButtonItem(
      barButtonSystemItem: .save, target: self, action: #selector(saveAction(_:))
    )
    navigationItem.rightBarButtonItem = rightBarButton
  }
  
  private func layout() {
    let padding: CGFloat = 8
    
    view.addSubview(titleTextField)
    view.addSubview(descriptionTextField)
    
    titleTextField.translatesAutoresizingMaskIntoConstraints = false
    descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
    
    titleTextField.setContentHuggingPriority(.defaultHigh, for: .vertical)
    descriptionTextField.setContentHuggingPriority(.defaultLow, for: .vertical)
    
    NSLayoutConstraint.activate([
      titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
      titleTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
      titleTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
      descriptionTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: padding),
      descriptionTextField.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
      descriptionTextField.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
      descriptionTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
    ])
  }
}
