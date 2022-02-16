import UIKit

protocol IMessageBottomViewDelegate: AnyObject {
  func bottomViewTapBegin(_ bottomView: IMessageBottomView)
}

class IMessageBottomView: UIView {
  //MARK: - Views
  lazy var flowLayout = IMessageCollectionViewLayout()
  lazy var iMessageCollectionView = IMessageCollectionView(
    frame: .zero, collectionViewLayout: flowLayout
  )
  
  lazy var tapGestureRecognizer: UITapGestureRecognizer = {
    let recognizer = UITapGestureRecognizer(
      target: self,
      action: #selector(tapGestureAction(_:))
    )
    recognizer.numberOfTapsRequired = 1
    return recognizer
  }()
  
  weak var delegate: IMessageBottomViewDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .systemPurple
    self.addGestureRecognizer(tapGestureRecognizer)
    
    setupCollectionView()
    layout()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  @objc func tapGestureAction(
    _ recognizer: UITapGestureRecognizer
  ) {
    delegate?.bottomViewTapBegin(self)
  }
}

//MARK: - Setup subviews
extension IMessageBottomView {
  private func setupCollectionView() {
    addSubview(iMessageCollectionView)
    iMessageCollectionView.translatesAutoresizingMaskIntoConstraints = false
  }
  
  private func layout() {
    NSLayoutConstraint.activate([
      iMessageCollectionView.topAnchor.constraint(
        equalTo: safeAreaLayoutGuide.topAnchor
      ),
      iMessageCollectionView.leadingAnchor.constraint(
        equalTo: safeAreaLayoutGuide.leadingAnchor
      ),
      iMessageCollectionView.trailingAnchor.constraint(
        equalTo: safeAreaLayoutGuide.trailingAnchor
      ),
      iMessageCollectionView.bottomAnchor.constraint(
        equalTo: safeAreaLayoutGuide.bottomAnchor
      ),
    ])
  }
}
