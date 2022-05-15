//
//  ViewController.swift
//  PlayWithCoreImage01
//
//  Created by 김호준 on 2022/05/15.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var imageView: UIImageView!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // 이미지를 돌려주는 option
    let ciImageOptions = [
      CIImageOption.applyOrientationProperty: true
    ]
    
    guard let url = Bundle.main.url(forResource: "IMG_7577", withExtension: "jpeg"),
          let ciimage = CIImage(contentsOf: url, options: ciImageOptions) else {
      return
    }
    
    imageView.image = UIImage(ciImage: ciimage.transformed(by: CGAffineTransform(scaleX: 0.125, y: 0.125)))
  }
}

