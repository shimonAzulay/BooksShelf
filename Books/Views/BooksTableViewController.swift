//
//  BooksTableViewController.swift
//  Books
//
//  Created by Shimon Azulay on 26/11/2022.
//

import UIKit
import Combine

class BooksTableViewController: UITableViewController {
  private var cancellable: AnyCancellable?
  let viewModel: BooksViewModel
  
  init(viewModel: BooksViewModel) {
    self.viewModel = viewModel
    super.init(style: .plain)
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(BookTableViewCell.self, forCellReuseIdentifier: BookTableViewCell.identifier)
    cancellable = viewModel.$books
      .sink { [weak self] _ in
        self?.tableView.reloadData()
      }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    do {
      print("Fetching books from table")
      try viewModel.fetchBooks()
    } catch {
      print(error.localizedDescription)
    }
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    tableView.frame.width * 2
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.books.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let bookModel = viewModel.books[indexPath.row]
    
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
