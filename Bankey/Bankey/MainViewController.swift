import UIKit

class MainViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupTabBar()
  }
  
  private func setupViews() {
    let summaryVC = AccountSummaryViewController()
    let moneyVC = MoveMoneyViewController()
    let moreVC = MoreViewController()
    
    summaryVC.setTabBarImage(imageName: "list.dash.header.rectangle", title: "Summary")
    moneyVC.setTabBarImage(imageName: "arrow.left.arrow.right", title: "Money")
    moreVC.setTabBarImage(imageName: "ellipsis.circle", title: "More")
  }
  
  private func setupTabBar() {
    
  }
}


class AccountSummaryViewController: UIViewController {
  
}

class MoveMoneyViewController: UIViewController {
  
}

class MoreViewController: UIViewController {
  
}
