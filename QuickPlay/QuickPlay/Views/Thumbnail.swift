//
//  Thumbnail.swift
//  QuickPlay
//
//  Created by 김호준 on 2021/12/21.
//
import UIKit
import AVFoundation

class Thumbnail: UIImageView {
  var thumbnailImage: UIImage?
  
  init() {
    super.init(frame: .zero)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  func setupImage(with url: URL) {
    let asset = AVAsset(url: url)
    let imageGenerator = AVAssetImageGenerator(asset: asset)
    imageGenerator.appliesPreferredTrackTransform = true
    var time = asset.duration
    time.value = min(time.value, 2)
    
    do {
      let imageReference = try imageGenerator.copyCGImage(
        at: time,
        actualTime: nil
      )
      thumbnailImage = UIImage(cgImage: imageReference)
    } catch {
      thumbnailImage = nil
    }
    setupImageView()
  }
  
  private func setupImageView() {
    self.image?.resizableImage(
      withCapInsets: UIEdgeInsets(
        top: 0,
        left: 0,
        bottom: 0,
        right: 0
      )
    )
    self.contentMode = .scaleAspectFit
    self.image = thumbnailImage
  }
}
