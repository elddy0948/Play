import UIKit
import AVKit

extension ViewController {
  override func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath) {
      let videoURL = videos[indexPath.row]
      avPlayer = AVPlayer(url: videoURL)
      let vc = AVPlayerViewController()
      vc.showsPlaybackControls = true
      vc.requiresLinearPlayback = true
//      vc.allowsPictureInPicturePlayback = false
      vc.player = avPlayer
      
      present(
        vc,
        animated: true,
        completion: nil
      )
    }
}
