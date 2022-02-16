import UIKit

class ViewController: UIViewController {
  
  lazy var iMessageBottomView = IMessageBottomView(
    frame: .zero
  )
  
  private let reuseIdentifier = "Cell"
  var bottomViewHeight: NSLayoutConstraint?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    setupBottomView()
    layout()
  }
  
  private func changeBottomViewHeight(with height: CGFloat) {
    bottomViewHeight?.isActive = false
    
    bottomViewHeight = iMessageBottomView.heightAnchor.constraint(
      equalToConstant: height
    )
    
    bottomViewHeight?.isActive = true
    
    UIView.animate(
      withDuration: 0.2,
      animations: {
        self.view.layoutIfNeeded()
      })
  }
}

extension ViewController: IMessageBottomViewDelegate {
  func bottomViewTapBegin(_ bottomView: IMessageBottomView) {
  }
}

//MARK: - UI Setup / Layout
extension ViewController {
  private func setupBottomView() {
    view.addSubview(iMessageBottomView)
    iMessageBottomView
      .translatesAutoresizingMaskIntoConstraints = false
    iMessageBottomView.delegate = self
    
    iMessageBottomView.iMessageCollectionView.delegate = self
    iMessageBottomView.iMessageCollectionView.dataSource = self
  }
  
  private func layout() {
    print("Layout")
    let safeAreaLayoutGuide = view.safeAreaLayoutGuide
    
    bottomViewHeight = iMessageBottomView.heightAnchor.constraint(
      equalToConstant: 50
    )
    
    guard let bottomViewHeight = bottomViewHeight else {
      return
    }
    
    NSLayoutConstraint.activate([
      iMessageBottomView.bottomAnchor.constraint(
        equalTo: view.bottomAnchor
      ),
      iMessageBottomView.leadingAnchor.constraint(
        equalTo: safeAreaLayoutGuide.leadingAnchor
      ),
      iMessageBottomView.trailingAnchor.constraint(
        equalTo: safeAreaLayoutGuide.trailingAnchor
      ),
      bottomViewHeight
    ])
  }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let itemHeight = collectionView.frame.height
    return CGSize(width: itemHeight, height: itemHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int
  ) -> CGFloat {
    return 8
  }
}

extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int
  ) -> Int {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
    cell.backgroundColor = .systemBlue
    return cell
  }
}

extension ViewController: UICollectionViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    changeBottomViewHeight(with: 80)
  }
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView,
                                willDecelerate decelerate: Bool) {
//    changeBottomViewHeight(with: 50)
  }
}
