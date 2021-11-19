import UIKit


class StoryCollectionViewCell: UICollectionViewCell {
  
  let profileImageView = ProfileImageView(frame: .zero)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureProfileImageView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  private func configureProfileImageView() {
    contentView.addSubview(profileImageView)
    profileImageView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      profileImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      profileImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
    ])
    
  }
}
