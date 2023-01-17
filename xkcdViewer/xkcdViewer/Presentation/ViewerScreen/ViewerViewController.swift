import UIKit

final class ViewerViewController: UIViewController {
  private let toolBar = ViewerToolBar()
  // scrollable image view
  private let mockView = UIView()
  private let tabBar = ViewerTabBar()
  
  private var isBarsVisible = true
  
  private let tapGestureRecognizer = UITapGestureRecognizer()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTapGestureRecognizer()
    style()
    layout()
  }
  
  @objc func tapAction() {
    let alphaValue: CGFloat
    
    if isBarsVisible {
      alphaValue = 0
    } else {
      alphaValue = 1
    }
    
    isBarsVisible.toggle()
    
    
    UIView.animate(withDuration: 0.5, animations: { [weak self] in
      self?.tabBar.alpha = alphaValue
      self?.toolBar.alpha = alphaValue
    })
  }
}

extension ViewerViewController {
  private func configureTapGestureRecognizer() {
    tapGestureRecognizer.numberOfTapsRequired = 1
    tapGestureRecognizer.addTarget(self, action: #selector(tapAction))
  }
  
  private func style() {
    mockView.backgroundColor = .systemYellow
    mockView.addGestureRecognizer(tapGestureRecognizer)
    
    tabBar.delegate = self
  }
  
  private func layout() {
    mockView.translatesAutoresizingMaskIntoConstraints = false
    toolBar.translatesAutoresizingMaskIntoConstraints = false
    tabBar.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(mockView)
    view.addSubview(toolBar)
    view.addSubview(tabBar)
    
    let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 44
    let navBarHeight = UINavigationController().navigationBar.frame.height
    let height = statusBarHeight + navBarHeight
    
    NSLayoutConstraint.activate([
      mockView.topAnchor.constraint(equalTo: view.topAnchor),
      mockView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      mockView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      mockView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      toolBar.topAnchor.constraint(equalTo: view.topAnchor),
      toolBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      toolBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      toolBar.heightAnchor.constraint(equalToConstant: height),
      
      tabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tabBar.heightAnchor.constraint(equalToConstant: height)
    ])
  }
}

extension ViewerViewController: ViewerTabBarDelegate {
  // TODO: - implementation network call
  func fetchNextImage() {
    print("Next")
  }
  
  func fetchPrevImage() {
    print("Prev")
  }
}
