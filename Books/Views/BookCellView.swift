//
//  BookCellView.swift
//  Books
//
//  Created by Shimon Azulay on 28/11/2022.
//

import UIKit

class BookCellView: UIView {
  private lazy var container: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
    return stackView
  }()
  
  private lazy var spacer: UIView = {
    let spacer = UIView()
    spacer.setContentHuggingPriority(.defaultLow, for: .vertical)
    return spacer
  }()
  
  private lazy var bookDetailsView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .equalSpacing
    return stackView
  }()
  
  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15.0)
    label.textColor = .white
    label.numberOfLines = 2
    label.lineBreakMode = .byWordWrapping
    return label
  }()
  
  lazy var authorLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 8.0)
    label.textColor = .white
    label.numberOfLines = 2
    label.lineBreakMode = .byWordWrapping
    return label
  }()
  
  lazy var bookImage: UIImageView = {
    let image = UIImageView()
    return image
  }()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
  }
}

private extension BookCellView {
  func setupView() {
    addSubview(bookImage)
    bookImage.translatesAutoresizingMaskIntoConstraints = false
    bookImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
    bookImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    bookImage.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    bookImage.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    container.addArrangedSubview(spacer)
    bookDetailsView.addArrangedSubview(titleLabel)
    bookDetailsView.addArrangedSubview(authorLabel)
    container.addArrangedSubview(bookDetailsView)
    addSubview(container)
    container.translatesAutoresizingMaskIntoConstraints = false
    container.topAnchor.constraint(equalTo: topAnchor).isActive = true
    container.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    container.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    container.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
  }
}


