//
//  BookViewModel.swift
//  Books
//
//  Created by Shimon Azulay on 26/11/2022.
//

import Foundation
import Combine

extension BookViewModel {
  enum Error: Swift.Error {
    case fetchImageCancelled
    case failedToFetchImage
  }
}

class BookViewModel {
  private let cache: ImageDataCache
  
  // MARK: - Life Cycle
  init(cache: ImageDataCache) {
    self.cache = cache
  }
  
  // MARK: - API
  func fetchImage(from url: URL) async throws -> Data {
    if let data = await cache.getItem(forKey: url.absoluteString) {
      return data
    }

    do {
      try Task.checkCancellation()
    } catch {
      throw BookViewModel.Error.fetchImageCancelled
    }
    
    guard let data = try? Data(contentsOf: url) else {
      throw BookViewModel.Error.failedToFetchImage
    }
    
    await cache.setItem(forKey: url.absoluteString, item: data)
    return data
  }
}
