import UIKit

final class FollowersListViewController: UIViewController {
  private var viewModel: FollowersListViewModel!
  
  init(viewModel: FollowersListViewModel) {
    super.init(nibName: nil, bundle: nil)
    self.viewModel = viewModel
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    bind(to: viewModel)
  }
  
  private func bind(to viewModel: FollowersListViewModel) {
    viewModel.items.observe(on: self, observerBlock: { [weak self] items in
      self?.updateItems(items)
    })
    viewModel.error.observe(on: self, observerBlock: { [weak self] error in
      self?.printError(error)
    })
  }
  
  private func updateItems(_ items: [FollowersListItemViewModel]) {
    //tableView.reloadData()
    print(items)
  }
  
  private func printError(_ error: String) {
    print(error)
  }
}
