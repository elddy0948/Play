import UIKit
import RxSwift

final class CreatePostViewController: UIViewController {
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
    saveTrigger.onNext(())
  }
}

//MARK: - UI Setup / Layout
extension CreatePostViewController {
  private func configureViewController() {
    view.backgroundColor = .systemBackground
    let rightBarButton = UIBarButtonItem(
      barButtonSystemItem: .save, target: self, action: #selector(saveAction(_:))
    )
    navigationItem.rightBarButtonItem = rightBarButton
  }
}
