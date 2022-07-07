//
//  ObserverType.swift
//  RxCoreClone
//
//  Created by 김호준 on 2022/07/08.
//

import Foundation


public protocol ObserverType {
  associatedtype E
  
  func on(event: Event<E>)
}
