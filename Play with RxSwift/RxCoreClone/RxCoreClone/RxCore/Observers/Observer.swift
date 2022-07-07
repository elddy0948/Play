//
//  Observer.swift
//  RxCoreClone
//
//  Created by 김호준 on 2022/07/08.
//

import Foundation

//Observer is initialised with eventHandler closure which gonna be called when new Event arrives
public final class Observer<E>: ObserverType {
  private let _handler: (Event<E>) -> Void
  
  public init(handler: @escaping (Event<E>) -> Void) {
    _handler = handler
  }
  
  public func on(event: Event<E>) {
    _handler(event)
  }
}
