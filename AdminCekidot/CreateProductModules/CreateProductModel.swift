//
//  CreateProductModel.swift
//  AdminCekidot
//
//  Created by Reza Harris on 28/11/21.
//

import Foundation

import Foundation
import SwiftUI

enum CreateProductModel {
  // MARK: DiscoverModel Use Cases
  enum Fetch {
    struct Request {
      var products: Product
      var dismissAction: DismissAction
    }
    struct Response {
      var dismissAction: DismissAction
    }
  }
}
