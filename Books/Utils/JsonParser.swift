//
//  JsonParser.swift
//  Books
//
//  Created by Shimon Azulay on 14/12/2020.
//

import Foundation

struct JsonParser {
  func parse(json: Data) throws -> [Book] {
    let decoder = JSONDecoder()
    return try decoder.decode([Book].self, from: json)
  }
}

