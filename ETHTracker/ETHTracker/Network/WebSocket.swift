//
//  WebSocket.swift
//  ETHTracker
//
//  Created by 김호준 on 2022/07/21.
//

import Foundation

final class WebSocket {
  private let baseURL = URL(string: "wss://pubwss.bithumb.com/pub/ws")!
  
  let session: URLSession
  let task: URLSessionWebSocketTask
  
  init(session: URLSession = URLSession.shared) {
    self.session = session
    self.task = self.session.webSocketTask(with: baseURL)
  }
  
  func send() {
    let form = SubscriptionForm(
      type: "ticker",
      symbols: [.ETH_KRW],
      tickTypes: [.halfHour]
    )
    
    do {
      let encodedForm = try JSONEncoder().encode(form)
      task.send(
        .data(encodedForm),
        completionHandler: { error in
          if let error = error {
            print(error)
          }
          print("Send Completed!")
        }
      )
    } catch {
      print("Failed to encode")
    }
  }
  
  func receive() {
    task.receive(completionHandler: { result in
      switch result {
      case .success(let message):
        switch message {
        case .data(let data):
          print(data)
        case .string(let string):
          print(string)
        @unknown default:
          fatalError()
        }
      case .failure(let error):
        print(error)
      }
    })
    
    task.resume()
  }
}
