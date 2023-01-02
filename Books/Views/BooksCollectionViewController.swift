//
//  ViewController.swift
//  Books
//
//  Created by Shimon Azulay on 14/12/2020.
//

import UIKit
import Combine

class BooksCollectionViewController: UICollectionViewController {
  private var cancellable: AnyCancellable?
  
  let viewModel: BooksViewModel
  
  init(collectionViewLayout: UICollectionViewLayout, viewModel: BooksViewModel) {
    self.viewModel = viewModel
    super.init(collectionViewLayout: collectionViewLayout)
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
    cancellable = viewModel.$books
      .sink { [weak self] _ in
        self?.collectionView.reloadData()
      }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    do {
      print("Fetching books from collection")
      try viewModel.fetchBooks()
    } catch {
      print(error.localizedDescription)
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    viewModel.books.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let bookModel = viewModel.books[indexPath.row]
    
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
