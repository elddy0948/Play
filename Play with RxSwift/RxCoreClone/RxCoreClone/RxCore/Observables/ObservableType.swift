//
//  ObservableType.swift
//  RxCoreClone
//
//  Created by 김호준 on 2022/07/08.
//

import Foundation

public protocol ObservableType {
  associatedtype E
  
  func subscribe<O: ObserverType>(observer: O) -> Disposable where O.E == E
}

