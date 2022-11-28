//
//  BookModel.swift
//  Books
//
//  Created by Shimon Azulay on 14/12/2020.
//

import Foundation

struct Book: Codable, Hashable, Identifiable {
  var id: String { title }
  let title: String
  let body: String
  let url: URL
  let placeholderColor: RGBColor
}
