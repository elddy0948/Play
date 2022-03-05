import UIKit
import RxSwift
import RxCocoa

class ReposViewController: UIViewController {
  //MARK: - Views
  private let tableView = UITableView()
  let searchController = UISearchController(searchResultsController: nil)
  private let searchTextField = UITextField()
  
  //MARK: - Properties
  var viewModel: ReposViewModel!
  private let disposeBag = DisposeBag()
  
  //MARK: - Initializer
  init(viewModel: ReposViewModel) {
    super.init(nibName: nil, bundle: nil)
    self.viewModel = viewModel
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  //MARK: - ViewController Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewController()
    setupSearchController()
    setupTableView()
    
    layout()
    
    bindViewModel()
  }
}

//MARK: - Bind ViewModel
extension ReposViewController {
  private func bindViewModel() {
    let input = ReposViewModel.Input(
      ready: self.rx.viewWillAppear.asDriver(),
      selectedIndex: tableView.rx.itemSelected.asDriver(),
      searchText: searchController.searchBar.rx.text.orEmpty.asDriver()
    )
    
    let output = viewModel.transform(input: input)
    
    output.repos
      .drive(
        tableView.rx.items(
          cellIdentifier: "Cell", cellType: UITableViewCell.self
        )
      ) { (row, element, cell) in
        var content = cell.defaultContentConfiguration()
        content.text = element.name
        cell.contentConfiguration = content
      }
      .disposed(by: disposeBag)
    
    output.loading
      .drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
      .disposed(by: disposeBag)
    
    output.selectedRepoId
      .drive(onNext: { [weak self] repoId in
        guard let self = self else { return }
        let alertController = UIAlertController(
          title: "\(repoId)", message: nil, preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(
          title: "OK", style: .cancel, handler: nil)
        )
        self.present(alertController, animated: true, completion: nil)
      })
      .disposed(by: disposeBag)
  }
}

//MARK: - UI Setup / Layout
extension ReposViewController {
  private func setupViewController() {
    view.backgroundColor = .systemBackground
    definesPresentationContext = true
  }
  
  private func setupSearchController() {
    searchController.searchResultsUpdater = nil
    searchController.hidesNavigationBarDuringPresentation = false
  }
  
  private func setupTableView() {
    tableView.tableHeaderView = searchController.searchBar
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
  }
  
  private func layout() {
    let safeAreaLayoutGuide = view.safeAreaLayoutGuide
    
    view.addSubview(tableView)
    
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
    ])
  }
}
