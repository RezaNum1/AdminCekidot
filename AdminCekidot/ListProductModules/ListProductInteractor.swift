//
//  ListProductInteractor.swift
//  AdminCekidot
//
//  Created by Reza Harris on 27/11/21.
//

import Foundation

protocol ListProductBusinessLogic {
  func fetch()
}

class ListProductInteractor: ListProductBusinessLogic {
  var presenter: ListProductPresentationLogic?
  func fetch() {
    var products: [Product] = []
    GeneralProductWorker.shared.fetchActiveProduct { result in
      switch result {
      case .success(let result):
        DispatchQueue.main.async {
          products = result
          let response = ListProductModel.Fetch.Response(products: products)
          self.presenter?.showFetched(response: response)
        }
      case .failure(let error):
        print(error)
      }
    }
  }
  
  func removeItem(request: ListProductModel.Fetch.RequestRemoveItem) {
    GeneralProductWorker.shared.delete(product: request.product) { result in
      switch result {
      case(.success(let state)):
        print("Success Delete The Item")
      case(.failure(let err)):
        print(err)
      }
    }
  }
}
