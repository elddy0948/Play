import UIKit

final class CuratedPhotoCell: UITableViewCell {
  static let reuseIdentifier = String(describing: CuratedPhotoCell.self)
  
  func bind(_ viewModel: PhotoCellViewModel) {
    contentView.backgroundColor = .systemBlue
  }
}
