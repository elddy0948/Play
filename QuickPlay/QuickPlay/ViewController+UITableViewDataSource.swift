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
      let cell = tableView.dequeueReusableCell(
        withIdentifier: reuseId,
        for: indexPath
      )
      
      var contentConfiguration = cell.defaultContentConfiguration()
      contentConfiguration.text = "Video \(indexPath.row)"
      
      cell.contentConfiguration = contentConfiguration
      return cell
  }
}
