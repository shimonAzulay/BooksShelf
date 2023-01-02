//
//  ImageDataCache.swift
//  Books
//
//  Created by Shimon Azulay on 27/11/2022.
//

import Foundation

class ImageDataCache {
  private let cache = NSCache<NSString, NSData>()
  
  subscript(key: String) -> Data? {
    get {
      let nsKey = key as NSString
      guard let nsData = cache.object(forKey: nsKey) else { return nil }
      return Data(referencing: nsData)
    }
    set(data) {
      let nsKey = key as NSString
      guard let data else {
        cache.removeObject(forKey: nsKey)
        return
      }
      let nsData = data as NSData
      cache.setObject(nsData, forKey: nsKey)
    }
  }
}
