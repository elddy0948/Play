//
//  VideoTableViewCell.swift
//  QuickPlay
//
//  Created by 김호준 on 2021/12/21.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
  
  static let reuseIdentifier = String(describing: VideoTableViewCell.self)
  
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.textColor = .label
    label.font = .preferredFont(forTextStyle: .title1)
    return label
  }()
  
  private lazy var thumbnailImageView: Thumbnail = {
    let thumbnail = Thumbnail()
    return thumbnail
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupThumbnail()
    setupTitleLabel()
    layout()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  func setupCellData(title: String, url: URL) {
    titleLabel.text = title
    thumbnailImageView.setupImage(with: url)
  }
}

//MARK: - UI
extension VideoTableViewCell {
  private func setupTitleLabel() {
    contentView.addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
  }
  
  private func setupThumbnail() {
    contentView.addSubview(thumbnailImageView)
    thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
  }
}

//MARK: - Layout
extension VideoTableViewCell {
  private func layout() {
    NSLayoutConstraint.activate([
      thumbnailImageView.topAnchor.constraint(
        equalTo: contentView.topAnchor,
        constant: 8
      ),
      thumbnailImageView.bottomAnchor.constraint(
        equalTo: contentView.bottomAnchor,
        constant: -8
      ),
      thumbnailImageView.widthAnchor.constraint(
        equalToConstant: 100
      ),
      thumbnailImageView.heightAnchor.constraint(
        equalToConstant: 100
      ),
      thumbnailImageView.leadingAnchor.constraint(
        equalTo: contentView.leadingAnchor,
        constant: 16
      ),
      titleLabel.centerYAnchor.constraint(
        equalTo: contentView.centerYAnchor
      ),
      titleLabel.leadingAnchor.constraint(
        equalTo: thumbnailImageView.trailingAnchor,
        constant: 8
      ),
      titleLabel.trailingAnchor.constraint(
        equalTo: contentView.trailingAnchor,
        constant: -16
      ),
    ])
  }
}
