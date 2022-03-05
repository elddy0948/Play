import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    window?.backgroundColor = .systemBackground
    
    let dependencies = ReposViewModel.Dependencies(networking: NetworkingApi())
    let viewModel = ReposViewModel(dependencies: dependencies)
    let viewController = ReposViewController(viewModel: viewModel)
    
    window?.rootViewController = viewController
    
    return true
  }
}

