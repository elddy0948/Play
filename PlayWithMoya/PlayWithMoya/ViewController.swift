import UIKit
import Moya

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let provider = MoyaProvider<Github>()
    
    provider.request(.fetchRepos(username: "elddy0948"), completion: { result in
      switch result {
      case .success(let response):
        let data = try? response.map([Repo].self)
        guard let repos = data else { return }
        print(repos)
      case .failure(let error):
        print(error.errorDescription ?? "Error!")
      }
    })
  }
}

