import UIKit
import RxCocoa
import RxSwift

final class SearchFollowersViewController: UIViewController {
  
  private lazy var flowLayout: UICollectionViewFlowLayout = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .vertical
    return flowLayout
  }()
  
  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    collectionView.backgroundColor = .systemBackground
    return collectionView
  }()
  
  private let bag = DisposeBag()
  var viewModel: SearchFollowersViewModel!
  var followers = [SearchFollowersItemViewModel]() {
    didSet {
      DispatchQueue.main.async { [weak self] in
        self?.collectionView.reloadData()
      }
    }
  }
  var downloadAvatarUseCase: DownloadAvatarUseCase?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    bindViewModel()
    
    setupCollectionView()
    layout()
  }
  
  private func bindViewModel() {
    let viewWillAppear = self.rx.viewWillAppear
      .asObservable()
    
    let input = SearchFollowersViewModel.Input(
      viewWillAppear: viewWillAppear
    )
    
    let output = viewModel.transform(input)
    
    output.followers
      .drive(onNext: { followers in
        self.followers = followers
      })
      .disposed(by: bag)
  }
}

//MARK: - UI Setup / Layout
extension SearchFollowersViewController {
  private func setupCollectionView() {
    collectionView.register(SearchFollowersCollectionViewCell.self,
                            forCellWithReuseIdentifier: SearchFollowersCollectionViewCell.reuseIdentifier)
    collectionView.delegate = self
    collectionView.dataSource = self
  }
  
  private func layout() {
    let safeAreaLayoutGuide = view.safeAreaLayoutGuide
    view.addSubview(collectionView)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}

extension SearchFollowersViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return followers.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: SearchFollowersCollectionViewCell.reuseIdentifier,
      for: indexPath) as? SearchFollowersCollectionViewCell else {
        return UICollectionViewCell()
      }
    
    let follower = followers[indexPath.item]
    
    if let avatarURL = follower.avatarURL {
      let provider = NetworkDownloadAvatarUseCaseProvider()
      downloadAvatarUseCase = provider.makeDownloadAvatarUseCase(avatarURL)
    }
    
    cell.backgroundColor = .systemBackground
    cell.configureData(follower, downloadAvatarUseCase: downloadAvatarUseCase)
    
    return cell
  }
}

extension SearchFollowersViewController: UICollectionViewDelegate {
  
}

extension SearchFollowersViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 4
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.bounds.width / 3 - 8, height: collectionView.bounds.height / 5)
  }
}
