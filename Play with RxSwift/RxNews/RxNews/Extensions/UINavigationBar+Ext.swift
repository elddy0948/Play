import UIKit

extension UINavigationBar {
  static func setupAppearance() {
    let barAppearance = UIBarAppearance()
    barAppearance.configureWithOpaqueBackground()
    barAppearance.backgroundColor = .systemBackground
    let navigationBarAppearance = UINavigationBarAppearance(barAppearance: barAppearance)
    UINavigationBar.appearance().standardAppearance = navigationBarAppearance
    UINavigationBar.appearance().compactAppearance = navigationBarAppearance
    
    if #available(iOS 15.0, *) {
      UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
  }
}
