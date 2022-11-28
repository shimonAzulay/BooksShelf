//
//  ImageDataCache.swift
//  Books
//
//  Created by Shimon Azulay on 27/11/2022.
//

import Foundation

actor ImageDataCache {
  private var cache = [String: Data]()
  
  func getItem(forKey key: String) -> Data? {
    cache[key]
  }

  func setItem(forKey key: String, item: Data) {
    cache[key] = item
  }
}
