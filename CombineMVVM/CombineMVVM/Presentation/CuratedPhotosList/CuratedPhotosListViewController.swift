import Combine
import UIKit

final class CuratedPhotosListViewController: UIViewController {
  
  private var cancellables = [AnyCancellable]()
  private let viewModel: CuratedPhotosListViewModel
  private let fetchPhotosByPage = PassthroughSubject<Int, Never>()
  private var currentPage = 1
  
  init(viewModel: CuratedPhotosListViewModel) {
    self.viewModel = viewModel
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
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
      .sink(receiveValue: { photos in
        print(photos.count)
      })
      .store(in: &cancellables)
  }
}
