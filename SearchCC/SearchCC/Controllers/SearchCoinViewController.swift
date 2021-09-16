import UIKit

class SearchCoinViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureSearchController()
  }
  
  private func configureSearchController() {
    let searchController = UISearchController(searchResultsController: nil)
    searchController.searchBar.placeholder = "Enter Coin ex)bitcoin"
    searchController.hidesNavigationBarDuringPresentation = false
    
    navigationItem.searchController = searchController
    navigationItem.title = "Search"
    navigationItem.hidesSearchBarWhenScrolling = false
  }
}

