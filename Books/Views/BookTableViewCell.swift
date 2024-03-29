//
//  BookTableViewCell.swift
//  Books
//
//  Created by Shimon Azulay on 26/11/2022.
//

import UIKit
import Combine

class BookTableViewCell: UITableViewCell {
  static let identifier = "bookTableViewCell"
  private var cancellable: AnyCancellable?
  private lazy var bookCellView: BookCellView = {
    let view = BookCellView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  var viewModel: BookViewModel? {
    didSet {
      cancellable = viewModel?.$imageData
        .compactMap { $0 }
        .sink { [weak self] in
          self?.bookCellView.bookImage.image = UIImage(data: $0)
          self?.bookCellView.titleLabel.isHidden = true
          self?.bookCellView.authorLabel.isHidden = true
      }
    }
  }
  
  var book: Book? {
    didSet {
      DispatchQueue.main.async { [weak self] in
        self?.populate()
      }
      
      fetchImage()
    }
  }
  
  // MARK: Life Cycle
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    cancellable?.cancel()
    cancellable = nil
    bookCellView.titleLabel.text = nil
    bookCellView.authorLabel.text = nil
    bookCellView.bookImage.image = nil
    bookCellView.bookImage.backgroundColor = nil
  }
}

private extension BookTableViewCell {
  func setupView() {
    contentView.addSubview(bookCellView)
    bookCellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
    bookCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
    bookCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
    bookCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
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
    
    do {
      try viewModel.fetchImage(from: imageUrl)
    } catch {
      print(error.localizedDescription)
    }
  }
}
