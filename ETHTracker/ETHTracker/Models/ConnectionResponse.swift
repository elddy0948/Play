//
//  ConnectionResponse.swift
//  ETHTracker
//
//  Created by 김호준 on 2022/07/21.
//

import Foundation

struct ConnectionResponse: Decodable {
  let status: String
  let resmsg: String
}
