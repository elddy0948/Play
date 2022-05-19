import UIKit
import RxSwift

final class EditPostViewController: UIViewController {
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
    return textField
  }()
  
  private let useCase: PostsUseCase?
  private let viewModel: EditPostViewModel?
  private let post: Post?
  
  private let editTriggerSubject = PublishSubject<Void>()
  private let deleteTriggerSubject = PublishSubject<Void>()
  private let titleSubject = PublishSubject<String>()
  private let descriptionsSubject = PublishSubject<String>()
  private let bag = DisposeBag()
  
  init(post: Post, useCase: PostsUseCase) {
    self.post = post
    self.useCase = useCase
    viewModel = EditPostViewModel(post: post, useCase: useCase)
    titleSubject.onNext(post.title)
    descriptionsSubject.onNext(post.body)
    super.init(nibName: nil, bundle: nil)
    
  }
  
  required init?(coder: NSCoder) {
    post = nil
    useCase = nil
    viewModel = nil
    
    super.init(coder: coder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bindViewModel()
    setupViewController()
    layout()
  }
  
  private func bindViewModel() {
    guard let viewModel = viewModel else {
      return
    }
    
    let inputs = EditPostViewModel.Input(
      editTrigger: editTriggerSubject.asObservable(),
      deleteTrigger: deleteTriggerSubject.asObservable(),
      title: titleSubject.asObservable(),
      descriptions: descriptionsSubject.asObservable()
    )
    
    let outputs = viewModel.transform(inputs)
    
    outputs.save
      .subscribe(onNext: { [weak self] in
        DispatchQueue.main.async {
          self?.navigationController?.popViewController(animated: true)
        }
      })
      .disposed(by: bag)
    
    outputs.post
      .subscribe(onNext: { post in
        print(post)
      })
      .disposed(by: bag)
    
    outputs.delete
      .subscribe(onNext: { [weak self] in
        DispatchQueue.main.async {
          self?.navigationController?.popViewController(animated: true)
        }
      })
      .disposed(by: bag)
  }
  
  @objc func deleteAction(_ sender: UIBarButtonItem) {
    deleteTriggerSubject.onNext(())
  }
  
  @objc func editAction(_ sender: UIBarButtonItem) {
    titleSubject.onNext(titleTextField.text ?? "")
    descriptionsSubject.onNext(descriptionTextField.text ?? "")
    editTriggerSubject.onNext(())
  }
}

extension EditPostViewController {
  private func setupViewController() {
    title = "Edit Post"
    view.backgroundColor = .systemBackground
    
    let deleteButton = UIBarButtonItem(
      barButtonSystemItem: .trash, target: self, action: #selector(deleteAction(_:))
    )
    
    let editButton = UIBarButtonItem(
      barButtonSystemItem: .edit, target: self, action: #selector(editAction(_:))
    )
    
    navigationItem.rightBarButtonItems = [editButton, deleteButton]
    
    guard let post = post else { return }
    
    titleTextField.text = post.title
    descriptionTextField.text = post.body
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
