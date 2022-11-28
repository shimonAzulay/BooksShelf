//
//  ViewController.swift
//  Books
//
//  Created by Shimon Azulay on 14/12/2020.
//

import UIKit
import Combine

class BooksCollectionViewController: UICollectionViewController {
  private var books: [Book] = [] {
    didSet {
      collectionView.reloadData()
    }
  }
  
  var viewModel: BooksViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)    
    Task { @MainActor in
      do {
        books = try await viewModel.fetchBooks()
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    books.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let bookModel = books[indexPath.row]
    
    guard let reusedCell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as? BookCollectionViewCell else {
      let bookView = BookCollectionViewCell()
      bookView.viewModel = BookViewModel(cache: viewModel.imageDataCache)
      bookView.book = bookModel
      return bookView
    }
    
    reusedCell.viewModel = BookViewModel(cache: viewModel.imageDataCache)
    reusedCell.book = bookModel
    return reusedCell
  }
}
