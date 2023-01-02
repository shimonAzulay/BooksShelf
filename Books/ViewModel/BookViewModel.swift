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

class BookViewModel: ObservableObject {
  private let cache: ImageDataCache
  
  // MARK: - Life Cycle
  init(cache: ImageDataCache) {
    self.cache = cache
  }
  
  // MARK: - API
  @Published var imageData: Data?
  
  func fetchImage(from url: URL) throws {
    Task { @MainActor [weak self] in
      self?.imageData = try await fetchImageAsync(from: url)
    }
  }
  
  private func fetchImageAsync(from url: URL) async throws -> Data {
    if let data = cache[url.absoluteString] {
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
    
    cache[url.absoluteString] = data
    return data
  }
}
