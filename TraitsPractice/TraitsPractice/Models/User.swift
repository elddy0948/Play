//
//  User.swift
//  TraitsPractice
//
//  Created by 김호준 on 2021/12/31.
//

import Foundation

struct User: Codable {
  let login: String
  let name: String
  let bio: String?
  let followers: Int
  let following: Int
}
