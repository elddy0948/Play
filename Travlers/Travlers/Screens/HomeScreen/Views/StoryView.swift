import UIKit


class StoryView: UIView {
  
  lazy var flowLayout: UICollectionViewFlowLayout = {
    let flowLayout = UICollectionViewFlowLayout()
    
    flowLayout.scrollDirection = .horizontal
    flowLayout.sectionInset = UIEdgeInsets(top: 8,
                                           left: 16,
                                           bottom: 8,
                                           right: 16)
    flowLayout.minimumLineSpacing = 16
    
    return flowLayout
  }()
  
  lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: flowLayout)
    collectionView.showsVerticalScrollIndicator = false
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.dataSource = self
//    collectionView.delegate = self
    collectionView.backgroundColor = .systemBlue
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
    return collectionView
  }()
  
  private let cellIdentifier = "cellIdentifier"
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .systemBlue
    setupCollectionView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    configureItemSize()
  }
  
  private func setupCollectionView() {
    addSubview(collectionView)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
    ])
  }
  
  private func configureItemSize() {
    let height = collectionView.frame.height - 16
    let width = height
    let itemSize = CGSize(width: width, height: height)
    flowLayout.itemSize = itemSize
  }
}

extension StoryView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 20
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
    cell.backgroundColor = .systemRed
    return cell
  }
}
