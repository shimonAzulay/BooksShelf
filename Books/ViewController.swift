//
//  ViewController.swift
//  Books
//
//  Created by Shimon Azulay on 14/12/2020.
//

import UIKit

class ViewController: UIViewController
{
    private weak var booksCollectionView: UICollectionView!
    private var data: [BookModel] = [] {
        didSet
        {
            self.layoutData()
        }
    }
    
    var jsonParser: JsonParserProtocol?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.createCollectionView()
        self.registerCollectionViewCell()
        
        self.jsonParser = JsonParser()
        
        guard let filePath = Bundle.main.url(forResource: "books", withExtension: "json") else
        {
            return
        }
        
        if let data = try? Data(contentsOf: filePath) {
            self.jsonParser?.parse(json: data) { result in
                switch result {
                case .success(let books):
                    self.data = books
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

extension ViewController
{
    private func layoutData()
    {
        DispatchQueue.main.async { [weak self] in
            self?.booksCollectionView.reloadData()
        }
    }
    
    private func createCollectionView()
    {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = self.view.backgroundColor
        collectionView.dataSource = self
        collectionView.delegate = self
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        self.booksCollectionView = collectionView
    }
    
    private func registerCollectionViewCell()
    {
        let bookCell = UINib(nibName: "BookCell", bundle: nil)
        self.booksCollectionView.register(bookCell, forCellWithReuseIdentifier: BookCell.cellIdentifier)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 100, height: 150)
    }
}

extension ViewController: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let bookModel = self.data[indexPath.row]
        
        guard let reusedCell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCell.cellIdentifier, for: indexPath) as? BookCell else {
            let cell = BookCell()
            cell.bookModel = bookModel
            return cell
        }
        
        reusedCell.bookModel = bookModel
        return reusedCell
    }
}

