import UIKit
import Combine

final class CuratedPhotoCell: UITableViewCell {
  static let reuseIdentifier = String(describing: CuratedPhotoCell.self)
  
  private let photoImageView = UIImageView()
  private let photographerLabel = UILabel()
  
  private var cancellable: AnyCancellable?
  
  override func prepareForReuse() {
    super.prepareForReuse()
    cancelImageLoading()
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureUI()
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func bind(_ viewModel: PhotoCellViewModel) {
    
    contentView.backgroundColor = .systemBackground
    
    photographerLabel.text = viewModel.photographer
    cancellable = viewModel.image.sink(
      receiveValue: { [unowned self] image in
        self.showImage(image)
      })
    
  }
  
  private func showImage(_ image: UIImage?) {
    cancelImageLoading()
    UIView.transition(
      with: self.photoImageView,
      duration: 0.2,
      options: [.curveEaseInOut, .transitionCrossDissolve],
      animations: {
        self.photoImageView.image = image
      })
  }
  
  private func configureUI() {
    photoImageView.contentMode = .scaleAspectFit
    
    photographerLabel.textColor = .label
    photographerLabel.textAlignment = .center
  }
  
  private func layout() {
    contentView.addSubview(photoImageView)
    contentView.addSubview(photographerLabel)
    
    photoImageView.translatesAutoresizingMaskIntoConstraints = false
    photographerLabel.translatesAutoresizingMaskIntoConstraints = false
    
    photographerLabel.setContentHuggingPriority(
      .defaultHigh, for: .vertical)
    
    NSLayoutConstraint.activate([
      photoImageView.topAnchor.constraint(
        equalToSystemSpacingBelow: contentView.topAnchor,
        multiplier: 2),
      photoImageView.leadingAnchor.constraint(
        equalToSystemSpacingAfter: contentView.leadingAnchor,
        multiplier: 2),
      contentView.trailingAnchor.constraint(
        equalToSystemSpacingAfter: photoImageView.trailingAnchor,
        multiplier: 2),
      photoImageView.heightAnchor.constraint(
        equalToConstant: 152),
      photographerLabel.topAnchor.constraint(
        equalToSystemSpacingBelow: photoImageView.bottomAnchor,
        multiplier: 1),
      photographerLabel.leadingAnchor.constraint(
        equalToSystemSpacingAfter: contentView.leadingAnchor,
        multiplier: 2),
      contentView.trailingAnchor.constraint(
        equalToSystemSpacingAfter: photographerLabel.trailingAnchor,
        multiplier: 2),
      contentView.bottomAnchor.constraint(
        equalToSystemSpacingBelow: photographerLabel.bottomAnchor,
        multiplier: 2)
    ])
  }
  
  private func cancelImageLoading() {
    photoImageView.image = nil
    cancellable?.cancel()
  }
}
