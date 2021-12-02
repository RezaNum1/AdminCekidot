//
//  ListProductPresenter.swift
//  AdminCekidot
//
//  Created by Reza Harris on 27/11/21.
//

import Foundation

protocol ListProductPresentationLogic {
  func showFetched(response: ListProductModel.Fetch.Response)
}

class ListProductPresenter: ObservableObject, ListProductPresentationLogic {
  @Published var products: [Product] = []
  @Published var isDone: Bool = false
  
  func showFetched(response: ListProductModel.Fetch.Response) {
    products = []
    products = response.products
    isDone = true
  }
}
