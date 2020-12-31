//
//  BookCell.swift
//  Books
//
//  Created by Shimon Azulay on 14/12/2020.
//

import UIKit

class BookCell: UICollectionViewCell
{
    @IBOutlet weak private var backgroundImage: UIImageView!
    @IBOutlet weak private var title: UILabel!
    @IBOutlet weak private var author: UILabel!
    
    static let cellIdentifier: String = "BookCell"
    
    var bookModel: BookModel? {
        didSet
        {
            self.layoutData()
        }
    }
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        self.backgroundImage.image = nil
        self.title.text = ""
        self.author.text = ""
    }
}

extension BookCell
{
    private func layoutData()
    {
        guard let bookModel = self.bookModel else {
            return
        }
        
        self.author.text = bookModel.body
        self.title.text = bookModel.title
        let red: CGFloat = CGFloat(bookModel.placeholderColor.red) / 255.0
        let green: CGFloat = CGFloat(bookModel.placeholderColor.green) / 255.0
        let blue: CGFloat = CGFloat(bookModel.placeholderColor.blue) / 255.0
        self.backgroundImage.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        
        self.downloadImage()
    }
    
    private func downloadImage()
    {
        // TODO
    }
}
