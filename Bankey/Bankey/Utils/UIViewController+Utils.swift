import UIKit

extension UIViewController {
  func setStatusBar() {
    let statusBarSize = view.window?.windowScene?.statusBarManager?.statusBarFrame.size ?? CGSize(width: 0, height: 0)
    let frame = CGRect(origin: .zero, size: statusBarSize)
    let statusBarView = UIView(frame: frame)
    
    statusBarView.backgroundColor = appColor
    view.addSubview(statusBarView)
  }
  
  func setTabBarImage(imageName: String, title: String) {
    let configuration = UIImage.SymbolConfiguration(scale: .large)
    let image = UIImage(systemName: imageName, withConfiguration: configuration)
    tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
  }
}
