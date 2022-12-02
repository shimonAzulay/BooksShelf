//
//  TabFactory.swift
//  Books
//
//  Created by Shimon Azulay on 28/11/2022.
//

import UIKit

extension Tab {
  func makeBooksViewController(viewModel: BooksViewModel) -> UIViewController {
    switch self {
    case .collection:
      let flowLayout = UICollectionViewFlowLayout()
      flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
      flowLayout.itemSize = CGSize(width: 100, height: 150)
      let booksCollectionViewController = BooksCollectionViewController(collectionViewLayout: flowLayout, viewModel: viewModel)
      return booksCollectionViewController
    case .table:
      let booksTableViewController = BooksTableViewController(viewModel: viewModel)
      return booksTableViewController
    case .list:
      return SwiftUIViewController.makeViewController(fromView: BooksListView(viewModel: viewModel))
    }
  }
}
