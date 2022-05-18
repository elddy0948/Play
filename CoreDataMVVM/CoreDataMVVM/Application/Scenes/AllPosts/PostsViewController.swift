import UIKit
import RxSwift

final class PostsViewController: UIViewController {
  private let coreDataUseCaseProvider: UseCaseProvider
  private let viewModel: PostsViewModel
  private var triggerSubject = PublishSubject<Void>()
  private let bag = DisposeBag()
  
  private var posts = [Post]() {
    didSet {
      DispatchQueue.main.async { [weak self] in
        self?.tableView.reloadData()
      }
    }
  }
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .systemBackground
    tableView.register(
      PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.reuseIdentifier
    )
    tableView.delegate = self
    tableView.dataSource = self
    return tableView
  }()
  
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
    configureViewController()
    layout()
    bindViewModel()
    triggerSubject.onNext(())
  }
  
  private func bindViewModel() {
    let input = PostsViewModel.Input(trigger: triggerSubject.asObservable())
    let output = viewModel.transform(input)
    output.posts
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { posts in
        print(posts)
        self.posts = posts
      })
      .disposed(by: bag)
  }
  
  @objc func addButtonAction(_ sender: UIBarButtonItem) {
    let vc = UINavigationController(rootViewController: CreatePostViewController())
    self.present(vc, animated: true)
  }
}

extension PostsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return posts.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: PostTableViewCell.reuseIdentifier, for: indexPath
    ) as? PostTableViewCell else {
      return UITableViewCell()
    }
    
    cell.configure(post: posts[indexPath.row])
    
    return cell
  }
}

extension PostsViewController: UITableViewDelegate {
  
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
  
  private func layout() {
    view.addSubview(tableView)
    
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
    ])
  }
}
