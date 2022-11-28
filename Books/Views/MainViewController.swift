//
//  MainViewController.swift
//  Books
//
//  Created by Shimon Azulay on 28/11/2022.
//

import UIKit

class MainViewController: UITabBarController {
  let viewModel = MainViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewControllers = viewModel.tabs.map {
      let vc = $0.makeBooksViewController(viewModel: viewModel.booksViewModel)
      vc.tabBarItem = UITabBarItem(title: $0.rawValue, image: .checkmark, selectedImage: .checkmark)
      return vc
    }
  }
}
