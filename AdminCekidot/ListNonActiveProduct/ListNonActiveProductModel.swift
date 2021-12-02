//
//  ListNonActiveProductModel.swift
//  AdminCekidot
//
//  Created by Reza Harris on 29/11/21.
//

import Foundation

enum ListNonActiveProductModel {
  // MARK: DiscoverModel Use Cases
  enum Fetch {
    struct RequestReActivateItem {
      var product: Product
    }
    struct Response {
      var products: [Product]
    }
  }
}
