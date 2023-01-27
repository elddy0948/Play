import Combine
import UIKit

final class CuratedPhotosListViewController: UIViewController {
  private var cancellables = [AnyCancellable]()
  private let viewModel: CuratedPhotosListViewModel
  private let fetchPhotosByPage = PassthroughSubject<Int, Never>()
  private var currentPage = 1
  
  //MARK: - Views
  private let tableView = UITableView()
  private lazy var dataSource = createDataSource()
  
  init(viewModel: CuratedPhotosListViewModel) {
    self.viewModel = viewModel
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    style()
    layout()
    bind(to: viewModel)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    // currentPage를 ViewModel에서 들고있어야하지 않을까?
    fetchPhotosByPage.send(currentPage)
  }
  
  //MARK: - ViewModel Stuff
  private func bind(to viewModel: CuratedPhotosListViewModel) {
    cancellables.forEach({ $0.cancel() })
    cancellables.removeAll()
    
    let input = CuratedPhotosListViewModel.Input(
      fetchPhotosByPage: self.fetchPhotosByPage.eraseToAnyPublisher())
    let output = viewModel.transform(input: input)
    
    output.photos
      .sink(receiveValue: { [unowned self] photos in
        self.update(with: photos)
      })
      .store(in: &cancellables)
  }
}

fileprivate extension CuratedPhotosListViewController {
  func style() {
    tableView.backgroundColor = .systemBackground
    tableView.register(
      CuratedPhotoCell.self,
      forCellReuseIdentifier: CuratedPhotoCell.reuseIdentifier)
  }
  
  func layout() {
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

fileprivate extension CuratedPhotosListViewController {
  enum Section: CaseIterable {
    case photos
  }
  
  func createDataSource(
  ) -> UITableViewDiffableDataSource<Section, PhotoCellViewModel> {
    return UITableViewDiffableDataSource(
      tableView: tableView,
      cellProvider: { tableView, indexPath, photoCellViewModel in
        guard let cell = tableView.dequeueReusableCell(
          withIdentifier: CuratedPhotoCell.reuseIdentifier,
          for: indexPath) as? CuratedPhotoCell else {
          return UITableViewCell()
        }
        cell.bind(photoCellViewModel)
        return cell
      })
  }
  
  func update(with photos: [PhotoCellViewModel], animate: Bool = true) {
    DispatchQueue.main.async {
      var snapshot = NSDiffableDataSourceSnapshot<Section, PhotoCellViewModel>()
      snapshot.appendSections(Section.allCases)
      snapshot.appendItems(photos, toSection: .photos)
      self.dataSource.apply(snapshot, animatingDifferences: animate)
    }
  }
}
