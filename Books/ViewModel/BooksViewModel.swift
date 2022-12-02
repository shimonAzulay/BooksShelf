//
//  BooksViewModel.swift
//  Books
//
//  Created by Shimon Azulay on 25/11/2022.
//

import Foundation
import Combine

extension BooksViewModel {
  enum Error: Swift.Error {
    case fetchBooksCancelled
    case failedToFetchBooks
  }
}

class BooksViewModel: ObservableObject {
  private let jsonParser = JsonParser()
  
  // MARK: API
  let imageDataCache = ImageDataCache()
  @Published var books = [Book]()
  
  func fetchBooks() throws {
    Task { @MainActor [weak self] in
      self?.books = try await fetchBooksAsync()
    }
  }
  
  private func fetchBooksAsync() async throws -> [Book] {
    do {
      try Task.checkCancellation()
    } catch {
      throw BookViewModel.Error.fetchImageCancelled
    }
    
    guard let filePath = Bundle.main.url(forResource: "books", withExtension: "json"),
          let data = try? Data(contentsOf: filePath),
          let books =  try? jsonParser.parse(json: data) else {
      throw BooksViewModel.Error.failedToFetchBooks
    }
    
    DispatchQueue.main.async { [weak self] in
      self?.books = books
    }
    
    return books
  }
}
