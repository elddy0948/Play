import RxSwift
import RxCocoa

final class ReposViewModel: ViewModelType {
  struct Input {
    let ready: Driver<Void>
    let selectedIndex: Driver<IndexPath>
    let searchText: Driver<String>
  }
  
  struct Output {
    let loading: Driver<Bool>
    let repos: Driver<[RepoViewModel]>
    let selectedRepoId: Driver<Int>
  }
  
  struct Dependencies {
    let networking: NetworkingService
  }
  
  private let dependencies: Dependencies
  
  init(dependencies: Dependencies) {
    self.dependencies = dependencies
  }
  
  func transform(input: Input) -> Output {
    let loading = ActivityIndicator()
    
    let initialRepos = input.ready
      .flatMap({ _ in
        self.dependencies.networking
          .searchRepos(with: "swift")
          .trackActivity(loading)
          .asDriver(onErrorJustReturn: [])
      })
    
    let searchRepos = input.searchText
      .filter({ $0.count > 2 })
      .throttle(.milliseconds(300))
      .distinctUntilChanged()
      .flatMapLatest({ query in
        self.dependencies.networking
          .searchRepos(with: query)
          .trackActivity(loading)
          .asDriver(onErrorJustReturn: [])
      })
    
    let repos = Driver.merge(initialRepos, searchRepos)
    
    let repoViewModels = repos.map({ repos in
      repos.map({ return RepoViewModel(repo: $0) })
    })
    
    let selectedRepoId = input.selectedIndex
      .withLatestFrom(repos, resultSelector: { (indexPath, repos) -> Repo in
        return repos[indexPath.item]
      })
      .map({ repo -> Int in
        return repo.id
      })
    
    return Output(
      loading: loading.asDriver(),
      repos: repoViewModels,
      selectedRepoId: selectedRepoId
    )
  }
}
