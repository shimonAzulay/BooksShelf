//
//  BookView.swift
//  Books
//
//  Created by Shimon Azulay on 25/11/2022.
//

import UIKit
import Combine

class BookCollectionViewCell: UICollectionViewCell {
  static let identifier = "bookCollectionViewCell"
  
  // MARK: Properties
  private lazy var bookCellView: BookCellView = {
    let view = BookCellView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  var viewModel: BookViewModel?
  var book: Book? {
    didSet {
      DispatchQueue.main.async { [weak self] in
        self?.populate()
      }
      
      fetchImage()
    }
  }
  
  // MARK: Life Cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    bookCellView.titleLabel.text = nil
    bookCellView.authorLabel.text = nil
    bookCellView.bookImage.image = nil
    bookCellView.bookImage.backgroundColor = nil
  }
}

private extension BookCollectionViewCell {
  func setupView() {
    contentView.addSubview(bookCellView)
    bookCellView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    bookCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    bookCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    bookCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
  }
  
  func populate() {
    guard let book else { return }
    bookCellView.titleLabel.text = book.title
    bookCellView.authorLabel.text = book.body
    bookCellView.bookImage.backgroundColor = UIColor(red: CGFloat(book.placeholderColor.red) / 255.0,
                                                     green: CGFloat(book.placeholderColor.green) / 255.0,
                                                     blue: CGFloat(book.placeholderColor.blue) / 255.0,
                                                     alpha: 1.0)
  }
  
  func fetchImage() {
    guard let imageUrl = book?.url,
          let viewModel else { return }
    
    Task { @MainActor in
      do {
        let imageData = try await viewModel.fetchImage(from: imageUrl)
        bookCellView.bookImage.image = UIImage(data: imageData)
        bookCellView.titleLabel.isHidden = true
        bookCellView.authorLabel.isHidden = true
      } catch {
        print(error.localizedDescription)
      }
    }
  }
}
