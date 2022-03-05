import UIKit

final class GreetingViewController: UIViewController {
  //MARK: - Views
  private let tableView = UITableView()
  
  //MARK: - Properties
  private let firestoreApi = FirestoreApi()
  private var cellModels = [CellModel]()
  
  //MARK: - ViewController Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViewController()
    setupTableView()
    layout()
  }
}

//MARK: - UITableViewDataSource
extension GreetingViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cellModels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: MyCell.reuseIdentifier,
      for: indexPath) as? MyCell else {
        return UITableViewCell()
      }
    let cellModel = cellModels[indexPath.row]
    cell.configureCellData(with: cellModel)
    return cell
  }
}

//MARK: - UITableViewDelegate
extension GreetingViewController: UITableViewDelegate {
  
}


//MARK: - UI Setup / Layout
extension GreetingViewController {
  private func setupViewController() {
    view.backgroundColor = .systemBackground
  }
  
  private func setupTableView() {
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.backgroundColor = .systemBackground
    tableView.register(MyCell.self, forCellReuseIdentifier: MyCell.reuseIdentifier)
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  private func layout() {
    view.addSubview(tableView)
    
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
