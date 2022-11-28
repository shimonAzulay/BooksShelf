//
//  BooksTableViewController.swift
//  Books
//
//  Created by Shimon Azulay on 26/11/2022.
//

import UIKit
import Combine

class BooksTableViewController: UITableViewController {
  private var books: [Book] = [] {
    didSet {
      tableView.reloadData()
    }
  }
  
  var viewModel: BooksViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(BookTableViewCell.self, forCellReuseIdentifier: BookTableViewCell.identifier)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    Task { @MainActor in
      do {
        books = try await viewModel.fetchBooks()
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    tableView.frame.width * 2
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    books.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let bookModel = books[indexPath.row]
    
    guard let reusedCell = tableView.dequeueReusableCell(withIdentifier: BookTableViewCell.identifier, for: indexPath) as? BookTableViewCell else {
      let bookView = BookTableViewCell()
      bookView.viewModel = BookViewModel(cache: viewModel.imageDataCache)
      bookView.book = bookModel
      return bookView
    }
    
    reusedCell.viewModel = BookViewModel(cache: viewModel.imageDataCache)
    reusedCell.book = bookModel
    return reusedCell
  }
}
