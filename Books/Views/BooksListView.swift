//
//  BooksListView.swift
//  Books
//
//  Created by Shimon Azulay on 28/11/2022.
//

import SwiftUI

struct BooksListView: View {
  @StateObject var viewModel: BooksViewModel
  
  var body: some View {
    NavigationView {
      List {
        ForEach(viewModel.books) {
          BookListItem(book: $0)
        }
      }
    }
    .onAppear {
      do {
        try viewModel.fetchBooks()
      } catch {
        print(error.localizedDescription)
      }
    }
  }
}
