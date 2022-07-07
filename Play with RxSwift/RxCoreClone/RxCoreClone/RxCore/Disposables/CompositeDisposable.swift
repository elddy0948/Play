//
//  CompositeDisposable.swift
//  RxCoreClone
//
//  Created by 김호준 on 2022/07/08.
//

import Foundation

// CompositeDisposable is basically a container for disposables that gonna call dispose on each of them when it disposed. And any attempt to add Disposable to already disposed CompositeDisposable will immediately dispose the other one
public final class CompositeDisposable: Disposable {
  private var isDisposed: Bool = false
  private var disposables = [Disposable]()
  
  public init() {}
  
  public func add(disposable: Disposable) {
    if isDisposed {
      disposable.dispose()
      return
    }
    disposables.append(disposable)
  }
  
  public func dispose() {
    if isDisposed { return }
    disposables.forEach({ $0.dispose() })
    isDisposed = true
  }
}
