import UIKit

class IMessageCollectionView: UICollectionView {
  
  override init(frame: CGRect,
                collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame,
               collectionViewLayout: layout)
    register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
}

