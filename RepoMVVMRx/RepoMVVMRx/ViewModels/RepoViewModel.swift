import Foundation

struct RepoViewModel {
  let name: String
}

extension RepoViewModel {
  init(repo: Repo) {
    self.name = repo.name
  }
}
