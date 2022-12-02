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
    
    cancellable = self.viewModel.objectWillChange.sink { [weak self] in
      self?.tableView.reloadData()
    }
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(BookTableViewCell.self, forCellReuseIdentifier: BookTableViewCell.identifier)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    do {
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
