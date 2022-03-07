import UIKit

final class GreetingViewController: UIViewController {
  //MARK: - Views
  private let tableView = UITableView()
  private let activityIndicator = UIActivityIndicatorView(style: .large)
  
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
    setupActivityIndicatorView()
    
    layout()
    
    fetchGreetings()
  }
}

//MARK: - Firestore
extension GreetingViewController {
  func fetchGreetings() {
    DispatchQueue.global(qos: .utility).async { [weak self] in
      self?.firestoreApi.fetchGreetings(completion: { cellModels in
        self?.activityIndicator.stopAnimating()
        if cellModels.count < 5 {
          self?.isLastPage = true
        }
        self?.isPaging = false
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
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let yOffset = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    let height = scrollView.frame.height
    
    if yOffset > (contentHeight - height) {
      if !isPaging && !isLastPage {
        //Paging!
        print("Paging!")
        activityIndicator.startAnimating()
        beginPaging()
      }
    }
  }
}

//MARK: - Paging Logic
extension GreetingViewController {
  private func beginPaging() {
    isPaging = true
    
    DispatchQueue.main.async {
      self.fetchGreetings()
    }
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
  
  private func setupActivityIndicatorView() {
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    activityIndicator.hidesWhenStopped = true
  }
  
  private func layout() {
    view.addSubview(tableView)
    view.addSubview(activityIndicator)
    
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
    
    NSLayoutConstraint.activate([
      activityIndicator.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
    ])
  }
}
