//
//  JsonParser.swift
//  Books
//
//  Created by Shimon Azulay on 14/12/2020.
//

import Foundation

enum JsonParserError: Error
{
    case FileNotFound
    case BadJsonFile
}

protocol JsonParserProtocol
{
    func parse(json: Data, complationHandler: (Result<[BookModel], JsonParserError>) -> Void)
}

struct JsonParser: JsonParserProtocol
{
    func parse(json: Data, complationHandler: (Result<[BookModel], JsonParserError>) -> Void)
    {
        let decoder = JSONDecoder()
        
        if let books = try? decoder.decode(Books.self, from: json) {
            complationHandler(.success(books.data))
        }
    }
    
    
}

