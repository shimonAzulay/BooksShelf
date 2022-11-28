//
//  MainViewModel.swift
//  Books
//
//  Created by Shimon Azulay on 28/11/2022.
//

import Foundation

class MainViewModel {
  let tabs = [Tab.collection, Tab.table, Tab.list]
  let booksViewModel = BooksViewModel()
}
