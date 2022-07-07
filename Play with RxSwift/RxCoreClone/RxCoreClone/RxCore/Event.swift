//
//  Event.swift
//  RxCoreClone
//
//  Created by 김호준 on 2022/07/08.
//

import Foundation

public enum Event<T> {
  case next(T)
  case error(Error)
  case completed
}
