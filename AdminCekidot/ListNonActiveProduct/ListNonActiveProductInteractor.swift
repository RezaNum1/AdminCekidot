//
//  ListNonActiveProductInteractor.swift
//  AdminCekidot
//
//  Created by Reza Harris on 29/11/21.
//

import Foundation

protocol ListNonActiveProductBusinessLogic {
  func fetch()
}

class ListNonActiveProductInteractor: ListNonActiveProductBusinessLogic {
  var presenter: ListNonActiveProductPresentationLogic?
  func fetch() {
    var products: [Product] = []
    GeneralProductWorker.shared.fetchNonActiveProduct { result in
      switch result {
      case .success(let result):
        DispatchQueue.main.async {
          products = result
          let response = ListNonActiveProductModel.Fetch.Response(products: products)
          self.presenter?.showFetched(response: response)
        }
      case .failure(let error):
        print(error)
      }
    }
  }
  
  func reActivateItem(request: ListNonActiveProductModel.Fetch.RequestReActivateItem) {
    GeneralProductWorker.shared.reActiveItem(product: request.product) { result in
      switch result {
      case(.success(let state)):
        print("Success Reactive The Item")
      case(.failure(let err)):
        print(err)
      }
    }
  }
}
