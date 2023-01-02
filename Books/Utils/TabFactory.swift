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
      let inset: CGFloat = 5.0
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                            heightDimension: .fractionalHeight(1.0))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(0.3))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                     subitems: [item])
      let section = NSCollectionLayoutSection(group: group)
      let layout = UICollectionViewCompositionalLayout(section: section)
      let booksCollectionViewController = BooksCollectionViewController(collectionViewLayout: layout, viewModel: viewModel)
      return booksCollectionViewController
    case .table:
      let booksTableViewController = BooksTableViewController(viewModel: viewModel)
      return booksTableViewController
    case .list:
      return SwiftUIViewController.makeViewController(fromView: BooksListView(viewModel: viewModel))
    }
  }
}
