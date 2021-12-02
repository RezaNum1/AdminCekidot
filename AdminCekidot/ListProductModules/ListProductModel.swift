//
//  ListProductModule.swift
//  AdminCekidot
//
//  Created by Reza Harris on 27/11/21.
//

import Foundation
import SwiftUI
import CloudKit

enum ListProductModel {
  // MARK: DiscoverModel Use Cases
  enum Fetch {
    struct RequestRemoveItem {
      var product: Product
    }
    struct Response {
      var products: [Product]
    }
  }
}

struct Product: Identifiable, Hashable {
  var id: UUID? = UUID()
  var recordID: CKRecord.ID?
  var name: String?
  var active: Bool = true
  var image: Data?
  var imageAssets: CKAsset?
  var imageSource: String?
  var category: String?
  var allergen: String?
  var productMass: String?
  var servingSize: String?
  var calories: String?
  var carbs: String?
  var fat: String?
  var protein: String?
  var saturates: String?
  var sodium: String?
  var sugar: String?
  var ingredientEng: String?
  var ingredientID: String?
  var createdAt: Date? = Date()
  var updatedAt: Date? = Date()
}
