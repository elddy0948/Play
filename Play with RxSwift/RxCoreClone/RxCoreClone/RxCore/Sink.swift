//
//  Sink.swift
//  RxCoreClone
//
//  Created by 김호준 on 2022/07/08.
//

import Foundation

final class Sink<O: ObserverType>: Disposable {
  private var _disposed: Bool = false
  private let _forward: O
  private let _subscriptionHandler: (Observer<O.E>) -> Disposable
  private let _composite = CompositeDisposable()
  
  init(forward: O, subscriptionHandler: @escaping (Observer<O.E>) -> Disposable) {
    _forward = forward
    _subscriptionHandler = subscriptionHandler
  }
  
  func run() {
    let observer = Observer<O.E>(handler: forward)
    _composite.add(disposable: _subscriptionHandler(observer))
  }
  
  private func forward(event: Event<O.E>) {
    if _disposed {
      return
    }
    
    _forward.on(event: event)
    
    switch event {
    case .completed, .error:
      self.dispose()
    default:
      break
    }
  }
  
  func dispose() {
    _disposed = true
    _composite.dispose()
  }
}
