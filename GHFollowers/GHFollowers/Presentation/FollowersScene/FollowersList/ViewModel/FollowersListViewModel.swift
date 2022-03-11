import Foundation

//MARK: - Input
protocol FollowersListViewModelInput {
  func didSearch(query: String)
  func didSelect(at indexPath: IndexPath)
}

//MARK: - Output
protocol FollowersListViewModelOutput {
  var items: Observable<[FollowersListItemViewModel]> { get }
  var error: Observable<String> { get }
}

protocol FollowersListViewModel: FollowersListViewModelInput, FollowersListViewModelOutput { }

struct FollowersListViewModelActions {
  let showFollowerDetails: (Follower) -> Void
}

final class DefaultFollowersListViewModel: FollowersListViewModel {
  var currentPage: Int = 0
  
  private let searchFollowersUseCase: SearchFollowersUseCase
  private let actions: FollowersListViewModelActions?
  private var followersLoadTask: Cancelable? {
    willSet {
      followersLoadTask?.cancel()
    }
  }
  
  private var followers: [Follower] = []
  private var pages: [FollowersPage] = []
  
  //MARK: - Output
  let items: Observable<[FollowersListItemViewModel]> = Observable([])
  var error: Observable<String> = Observable("")
  
  //MARK: - Initializer
  init(searchFollowersUseCase: SearchFollowersUseCase,
       actions: FollowersListViewModelActions
  ) {
    self.searchFollowersUseCase = searchFollowersUseCase
    self.actions = actions
  }
  
  private func appendPage(_ followersPage: FollowersPage) {
    currentPage = followersPage.page
    
    pages = pages
      .filter({ $0.page != followersPage.page }) + [followersPage]
    
    items.value = pages.followers.map({ return FollowersListItemViewModel(follower: $0) })
  }
  
  private func load(followerQuery: FollowerQuery) {
    let requestValue = SearchFollowersUseCaseRequestValue.init(
      query: followerQuery,
      page: 1
    )
    
    followersLoadTask = searchFollowersUseCase.execute(
      requestValue: requestValue,
      cached: appendPage(_:),
      completion: { result in
        switch result {
        case .success(let page):
          self.appendPage(page)
        case .failure(let error):
          print(error)
        }
      })
  }
  
  private func resetPages() {
    currentPage = 0
    pages.removeAll()
    items.value.removeAll()
  }
  
  private func update(query: FollowerQuery) {
    resetPages()
    load(followerQuery: query)
  }
}

//MARK: - Input
extension DefaultFollowersListViewModel {
  func didSearch(query: String) {
    guard !query.isEmpty else { return }
    let followerQuery = FollowerQuery(query: query)
    update(query: followerQuery)
  }
  
  func didSelect(at indexPath: IndexPath) {
  }
}

private extension Array where Element == FollowersPage {
    var followers: [Follower] { flatMap { $0.followers } }
}
