//
//  ViewController.swift
//  ETHTracker
//
//  Created by 김호준 on 2022/07/21.
//

import UIKit

class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    let webSocket = WebSocket()
    webSocket.receive()
  }


}

