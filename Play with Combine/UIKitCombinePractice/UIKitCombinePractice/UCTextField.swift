import UIKit

final class UCTextField: UITextField {
  init(placeholder: String, imageName: String) {
    super.init(frame: .zero)
    let leftImage = UIImage(systemName: imageName)
    let imageView = UIImageView(image: leftImage)
    imageView.tintColor = .label
    
    self.backgroundColor = .secondarySystemBackground
    self.leftViewMode = .always
    self.leftView = imageView
    self.placeholder = placeholder
    self.layer.cornerRadius = 8
    self.layer.masksToBounds = true
    self.autocorrectionType = .no
    self.autocapitalizationType = .none
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
