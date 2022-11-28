//
//  SwiftUIViewLoader.swift
//  Books
//
//  Created by Shimon Azulay on 28/11/2022.
//

import UIKit
import SwiftUI

struct SwiftUIViewController {
  static func makeViewController(fromView view: some View) -> UIViewController {
    UIHostingController(rootView: view)
  }
}
