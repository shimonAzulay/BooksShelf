//
//  BookListCell.swift
//  Books
//
//  Created by Shimon Azulay on 28/11/2022.
//

import SwiftUI

struct BookListItem: View {
  let book: Book
  
  var body: some View {
    ZStack(alignment: .leading) {
      AsyncImage(url: book.url, content: { image in
        image.resizable()
      }, placeholder: {
        Color(red: CGFloat(book.placeholderColor.red) / 255.0,
              green: CGFloat(book.placeholderColor.green) / 255.0,
              blue: CGFloat(book.placeholderColor.blue) / 255.0)
      })
      VStack(alignment: .leading, spacing: 5) {
        Spacer()
        Text(book.title)
          .font(.system(size: 15))
        Text(book.body)
          .font(.system(size: 8))
      }
      .padding(
        EdgeInsets(
          top: 0,
          leading: 5,
          bottom: 5,
          trailing: 0
        )
      )
    }
    .frame(
      minWidth: 0,
      maxWidth: .infinity,
      minHeight: 400,
      maxHeight: 600,
      alignment: .topLeading
    )
  }
}
