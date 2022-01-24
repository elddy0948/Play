import UIKit

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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    
    setupTableView()
    layout()
  }
}

//MARK: - UITableViewDataSource
extension NewsHomeViewController: UITableViewDataSource {
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return 5
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
    
    return cell
  }
}

//MARK: - UITableViewDelegate
extension NewsHomeViewController: UITableViewDelegate {
  
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
