//
//  ListNonActiveProductPresenter.swift
//  AdminCekidot
//
//  Created by Reza Harris on 29/11/21.
//

import Foundation

protocol ListNonActiveProductPresentationLogic {
  func showFetched(response: ListNonActiveProductModel.Fetch.Response)
}

class ListNonActiveProductPresenter: ObservableObject, ListNonActiveProductPresentationLogic {
  @Published var products: [Product] = []
  @Published var isDone: Bool = false
  
  func showFetched(response: ListNonActiveProductModel.Fetch.Response) {
    products = []
    products = response.products
    isDone = true
  }
}
