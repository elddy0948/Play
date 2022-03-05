import UIKit

final class GreetingViewController: UIViewController {
  //MARK: - Views
  private let tableView = UITableView()
  
  //MARK: - Properties
  private let firestoreApi = FirestoreApi()
  private var cellModels = [CellModel]() {
    didSet {
      tableView.reloadData()
    }
  }
  private var isPaging = false
  private var isLastPage = false
  
  //MARK: - ViewController Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViewController()
    setupTableView()
    layout()
    
    fetchGreetings()
  }
}

//MARK: - Firestore
extension GreetingViewController {
  func fetchGreetings() {
    DispatchQueue.global(qos: .utility).async { [weak self] in
      self?.firestoreApi.fetchGreetings(completion: { cellModels in
        if cellModels.count < 5 {
          self?.isLastPage = true
        }
        self?.cellModels += cellModels
      })
    }
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
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 150
  }
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
