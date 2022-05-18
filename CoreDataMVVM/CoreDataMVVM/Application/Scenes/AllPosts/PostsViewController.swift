import UIKit
import RxSwift

final class PostsViewController: UIViewController {
  private let coreDataUseCaseProvider: UseCaseProvider
  private let viewModel: PostsViewModel
  private var triggerSubject = PublishSubject<Void>()
  private let bag = DisposeBag()
  
  init() {
    self.coreDataUseCaseProvider = CDUseCaseProvider()
    self.viewModel = PostsViewModel(useCase: coreDataUseCaseProvider.makePostsUseCase())
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    self.coreDataUseCaseProvider = CDUseCaseProvider()
    self.viewModel = PostsViewModel(useCase: coreDataUseCaseProvider.makePostsUseCase())
    super.init(coder: coder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bindViewModel()
    configureViewController()
    triggerSubject.onNext(())
  }
  
  private func bindViewModel() {
    let input = PostsViewModel.Input(trigger: triggerSubject.asObservable())
    let output = viewModel.transform(input)
    output.posts
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { posts in
        print(posts)
      })
      .disposed(by: bag)
  }
  
  @objc func addButtonAction(_ sender: UIBarButtonItem) {
    let vc = UINavigationController(rootViewController: CreatePostViewController())
    self.present(vc, animated: true)
  }
}

//MARK: - UI Setup / Layout
extension PostsViewController {
  private func configureViewController() {
    title = "All Posts"
    view.backgroundColor = .systemBackground
    let rightBarButton = UIBarButtonItem(
      barButtonSystemItem: .add, target: self, action: #selector(addButtonAction(_:))
    )
    navigationItem.rightBarButtonItem = rightBarButton
  }
}
