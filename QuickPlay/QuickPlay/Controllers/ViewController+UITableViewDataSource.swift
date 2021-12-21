//
//  ViewController+UITableViewDataSource.swift
//  QuickPlay
//
//  Created by 김호준 on 2021/12/20.
//

import UIKit

extension ViewController {
  override func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int {
    return videos.count
  }
  
  override func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(
        withIdentifier: VideoTableViewCell.reuseIdentifier,
        for: indexPath
      ) as? VideoTableViewCell else {
        return UITableViewCell()
      }
      
      let videoURL = videos[indexPath.row]
      cell.setupCellData(title: "Video \(indexPath.row)", url: videoURL)
      
      return cell
  }
}
