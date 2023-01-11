import UIKit

final class MovieListViewController: UIViewController {
  private let tableView = UITableView()
  
  private let storageProvider: StorageProvider
  private var movies: [Movie] = [] {
    didSet {
      updateTableView()
    }
  }
  
  init(storageProvider: StorageProvider) {
    self.storageProvider = storageProvider
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    style()
    layout()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.movies = storageProvider.getAllMovies()
  }
  
  private func updateTableView() {
    DispatchQueue.main.async { [weak self] in
      self?.tableView.reloadData()
    }
  }
}

extension MovieListViewController {
  private func style() {
    view.backgroundColor = .systemBackground
    
    tableView.register(UITableViewCell.self,
                       forCellReuseIdentifier: "cell")
    tableView.backgroundColor = .systemBackground
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  private func layout() {
    tableView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(tableView)
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
    ])
  }
}

extension MovieListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movies.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    var content = cell.defaultContentConfiguration()
    content.text = movies[indexPath.row].name ?? "No name"
    cell.contentConfiguration = content
    return cell
  }
}

extension MovieListViewController: UITableViewDelegate {}
