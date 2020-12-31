//
//  BookModel.swift
//  Books
//
//  Created by Shimon Azulay on 14/12/2020.
//

import Foundation

struct BookModel: Codable
{
    var title: String
    var body: String
    var url: URL
    var placeholderColor: RGBColorModel
}
