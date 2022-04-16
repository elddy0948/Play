import UIKit

protocol AllChampCellDelegate: AnyObject {
  func addFavorite(_ champion: Champion?)
}

final class AllChampCell: UITableViewCell {
  @IBOutlet weak var chapNameLabel: UILabel!
  var champion: Champion?
  weak var delegate: AllChampCellDelegate?
  
  func configure(_ champ: Champion) {
    chapNameLabel.text = champ.name
    self.champion = champ
  }
  
  @IBAction func addFavorite(_ sender: UIButton) {
    delegate?.addFavorite(self.champion)
  }
}
