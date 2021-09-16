import UIKit

class SearchCoinViewController: UIViewController {
  
  private var searchCryptoView: SearchCryptoView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureSearchController()
    configureSearchCryptoView()
  }
  
  private func configureSearchController() {
    let searchController = UISearchController(searchResultsController: nil)
    searchController.searchBar.placeholder = "Enter Coin ex)bitcoin"
    searchController.hidesNavigationBarDuringPresentation = false
    searchController.searchBar.autocapitalizationType = .none
    searchController.searchBar.autocorrectionType = .no
    
    navigationItem.searchController = searchController
    navigationItem.title = "Search"
    navigationItem.hidesSearchBarWhenScrolling = false
  }
  
  private func configureSearchCryptoView() {
    searchCryptoView = SearchCryptoView()
    view.addSubview(searchCryptoView)
    
    NSLayoutConstraint.activate([
      searchCryptoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      searchCryptoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      searchCryptoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      searchCryptoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}

