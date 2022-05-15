import UIKit
import CoreImage
import CoreImage.CIFilterBuiltins

class ViewController: UIViewController {
  
  @IBOutlet weak var imageView: UIImageView!
  var ciimage: CIImage?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // 이미지를 돌려주는 option
    let ciImageOptions = [
      CIImageOption.applyOrientationProperty: true
    ]
    
    guard let url = Bundle.main.url(forResource: "IMG_7577", withExtension: "jpeg") else {
      return
    }
    ciimage = CIImage(contentsOf: url, options: ciImageOptions)
    
    guard let image = ciimage?.transformed(by: CGAffineTransform(scaleX: 0.125, y: 0.125)) else { return }
    imageView.image = UIImage(ciImage: image)
  }
  
  @IBAction func filterButtonAction(_ sender: UIButton) {
    let filter = CIFilter.vibrance()
    filter.amount = 0.9
    filter.inputImage = ciimage?.transformed(by: CGAffineTransform(scaleX: 0.125, y: 0.125))
    guard let output = filter.outputImage else { return }
    imageView.image = UIImage(ciImage: output)
  }
}

