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
    
    guard let image = ciimage else { return }
    
    let filter = CIFilter.vibrance()
    filter.amount = 0.9
    filter.inputImage = image
    
    let filter2 = CIFilter.gloom()
    filter2.radius = 10
    filter2.intensity = 0.7
    filter2.inputImage = filter.outputImage
    
    let filter3 = CIFilter.vignette()
    filter3.intensity = 0.9
    filter3.radius = 2
    filter3.inputImage = filter2.outputImage
    
    guard let finishedImage = filter3.outputImage?.cropped(to: image.extent) else { return }
//    let context = CIContext()
//    guard let cgImage = context.createCGImage(finishedImage, from: finishedImage.extent) else { return }
//
    let context = CIContext()
    guard let jpegURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
    
    let writeURL = jpegURL.appendingPathComponent("IMG_7577.jpeg")
    print(writeURL)
    
    try! context.writeJPEGRepresentation(of: finishedImage, to: writeURL, colorSpace: CGColorSpace(name: CGColorSpace.sRGB)!)
    
//    imageView.image = UIImage(cgImage: cgImage)
  }
}

