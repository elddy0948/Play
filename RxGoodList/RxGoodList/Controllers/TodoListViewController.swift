import UIKit

protocol TodoListViewControllerDelegate: AnyObject {
  func didTappedAddButton(_ viewController: TodoListViewController)
}

class TodoListViewController: UIViewController {
  //MARK: - Views
  lazy var segmentedControl: UISegmentedControl = {
    let segmentedControl = UISegmentedControl()
    segmentedControl.insertSegment(
      withTitle: "All", at: 0, animated: true
    )
    segmentedControl.insertSegment(
      withTitle: "High", at: 1, animated: true
    )
    segmentedControl.insertSegment(
      withTitle: "Medium", at: 2, animated: true
    )
    segmentedControl.insertSegment(
      withTitle: "Low", at: 3, animated: true
    )
    return segmentedControl
  }()
  
  lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    tableView.backgroundColor = .systemBackground
    return tableView
  }()
  
  weak var delegate: TodoListViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewController()
    setupAddButton()
    setupSegmentedControl()
    setupTableView()
    layout()
  }
  
  private func setupViewController() {
    view.backgroundColor = .systemBackground
    navigationController?.navigationBar.prefersLargeTitles = true
    title = "Todo"
  }
  
  //MARK: - Actions
  @objc func addButtonAction(_ barButton: UIBarButtonItem) {
    delegate?.didTappedAddButton(self)
  }
  
  @objc func segmentedControlChanged(_ segmentedControl: UISegmentedControl) {
    print(segmentedControl.selectedSegmentIndex)
  }
}

//MARK: - UI Setup / Layout
extension TodoListViewController {
  //Right bar(Add button)
  private func setupAddButton() {
    let barButtonItem = UIBarButtonItem(
      barButtonSystemItem: .add, target: self,
      action: #selector(addButtonAction(_:))
    )
    navigationItem.setRightBarButton(barButtonItem,
                                     animated: true)
  }
  
  //Segmented Control
  private func setupSegmentedControl() {
    view.addSubview(segmentedControl)
    segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    
    segmentedControl.addTarget(
      self, action: #selector(segmentedControlChanged(_:)),
      for: .valueChanged
    )
  }
  
  //TableView
  private func setupTableView() {
    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  //Layout
  private func layout() {
    let safeAreaLayoutGuide = view.safeAreaLayoutGuide
    
    NSLayoutConstraint.activate([
      segmentedControl.topAnchor.constraint(
        equalTo: safeAreaLayoutGuide.topAnchor, constant: 8
      ),
      segmentedControl.centerXAnchor.constraint(
        equalTo: safeAreaLayoutGuide.centerXAnchor
      ),
      tableView.topAnchor.constraint(
        equalTo: segmentedControl.bottomAnchor,
        constant: 8
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

extension TodoListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
    return cell
  }
}

extension TodoListViewController: UITableViewDelegate {
  
}
