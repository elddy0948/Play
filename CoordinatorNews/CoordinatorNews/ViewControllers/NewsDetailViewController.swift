import UIKit

class NewsDetailViewController: UIViewController {
  private lazy var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.backgroundColor = .systemBackground
    return scrollView
  }()
  
  private var newsDetailView: NewsDetailView?
  
  init(news: News) {
    newsDetailView = NewsDetailView(news: news)
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    newsDetailView = nil
    super.init(coder: coder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    setupScrollView()
    setupDetailView()
    layout()
  }
}

//MARK: - UI Setup / Layout
extension NewsDetailViewController {
  private func setupScrollView() {
    view.addSubview(scrollView)
    scrollView.translatesAutoresizingMaskIntoConstraints = false
  }
  
  private func setupDetailView() {
    guard let newsDetailView = newsDetailView else { return }
    scrollView.addSubview(newsDetailView)
    newsDetailView.translatesAutoresizingMaskIntoConstraints = false
  }
  
  private func layout() {
    let safeAreaLayoutGuide = view.safeAreaLayoutGuide
    let scrollViewReadable = scrollView.readableContentGuide
    guard let newsDetailView = newsDetailView else { return }
    
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(
        equalTo: safeAreaLayoutGuide.topAnchor
      ),
      scrollView.leadingAnchor.constraint(
        equalTo: safeAreaLayoutGuide.leadingAnchor
      ),
      scrollView.trailingAnchor.constraint(
        equalTo: safeAreaLayoutGuide.trailingAnchor
      ),
      scrollView.bottomAnchor.constraint(
        equalTo: safeAreaLayoutGuide.bottomAnchor
      ),
      newsDetailView.topAnchor.constraint(
        equalTo: scrollViewReadable.topAnchor
      ),
      newsDetailView.leadingAnchor.constraint(
        equalTo: scrollViewReadable.leadingAnchor
      ),
      newsDetailView.trailingAnchor.constraint(
        equalTo: scrollViewReadable.trailingAnchor
      ),
//      newsDetailView.bottomAnchor.constraint(
//        equalTo: scrollViewReadable.bottomAnchor
//      ),
      newsDetailView.widthAnchor.constraint(
        equalTo: scrollViewReadable.widthAnchor
      )
    ])
  }
}

