import UIKit
import RxSwift

protocol NewsHomeViewControllerDelegate: AnyObject {
  func didSelectNews(_ viewController: UIViewController,
                     news: News)
}

class NewsHomeViewController: UIViewController {
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .systemBackground
    tableView.tableFooterView = UIView()
    
    tableView.register(
      NewsTableViewCell.self,
      forCellReuseIdentifier: NewsTableViewCell.reuseIdentifier
    )
    
    return tableView
  }()
  
  private let bag = DisposeBag()
  private var newsResponse: NewsResponse? {
    didSet {
      tableView.reloadData()
    }
  }
  weak var delegate: NewsHomeViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    
    setupTableView()
    layout()
    
    fetchHeadLines()
  }
  
  private func fetchHeadLines() {
    NetworkAPI.shared.fetchHeadLines()
      .observe(on: MainScheduler.instance)
      .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .utility))
      .subscribe(
        onNext: { [weak self] response in
          guard let self = self else { return }
          DispatchQueue.main.async {
            self.newsResponse = response
          }
        },
        onError: { error in
          print(error)
        },
        onCompleted: {},
        onDisposed: {}
      )
      .disposed(by: bag)
  }
}

//MARK: - UITableViewDataSource
extension NewsHomeViewController: UITableViewDataSource {
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    guard let news = newsResponse?.articles else { return 0 }
    return news.count
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: NewsTableViewCell.reuseIdentifier,
      for: indexPath
    ) as? NewsTableViewCell else {
      return UITableViewCell()
    }
    
    if let news = newsResponse?.articles {
      let oneNews = news[indexPath.row]
      cell.configureNews(oneNews)
    }
    
    return cell
  }
}

//MARK: - UITableViewDelegate
extension NewsHomeViewController: UITableViewDelegate {
  func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    guard let newses = newsResponse?.articles else { return }
    let news = newses[indexPath.row]
    delegate?.didSelectNews(self, news: news)
  }
}

//MARK: - UI Setup / Layout
extension NewsHomeViewController {
  private func setupTableView() {
    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  private func layout() {
    let safeAreaLayoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(
        equalTo: safeAreaLayoutGuide.topAnchor
      ),
      tableView.leadingAnchor.constraint(
        equalTo: safeAreaLayoutGuide.leadingAnchor
      ),
      tableView.trailingAnchor.constraint(
        equalTo: safeAreaLayoutGuide.trailingAnchor
      ),
      tableView.bottomAnchor.constraint(
        equalTo: safeAreaLayoutGuide.bottomAnchor
      ),
    ])
  }
}
