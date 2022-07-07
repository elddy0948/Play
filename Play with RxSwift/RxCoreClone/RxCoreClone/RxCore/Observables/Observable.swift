//
//  Observable.swift
//  RxCoreClone
//
//  Created by 김호준 on 2022/07/08.
//

import Foundation

public class Observable<Element>: ObservableType {
  public typealias E = Element
  
  private let _subscribeHandler: (Observer<Element>) -> Disposable
  
  public init(
    _ subscriptionClosure: @escaping (Observer<Element>) -> Disposable
  ) {
    _subscribeHandler = subscriptionClosure
  }
  
  public func subscribe<O: ObserverType>(
    observer: O
  ) -> Disposable where E == O.E {
    let composite = CompositeDisposable()
    let subscription = _subscribeHandler(Observer(handler: { event in
      observer.on(event: event)
      switch event {
      case .error, .completed:
        composite.dispose()
      default:
        break
      }
    }))
    composite.add(disposable: subscription)
    return composite
  }
}
