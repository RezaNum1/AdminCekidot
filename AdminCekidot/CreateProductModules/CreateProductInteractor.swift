//
//  CreateProductInteractor.swift
//  AdminCekidot
//
//  Created by Reza Harris on 28/11/21.
//

import Foundation

protocol CreateProductBusinessLogic {
  func createProduct(request: CreateProductModel.Fetch.Request)
}

class CreateProductInteractor: CreateProductBusinessLogic {
  var presenter: CreateProductPresentationLogic?
  let productWorker = GeneralProductWorker.shared
  
  func createProduct(request: CreateProductModel.Fetch.Request) {
    
    productWorker.save(item: request.products) { result in
      switch result {
      case .success(let isDone):
        DispatchQueue.main.async {
          let response = CreateProductModel.Fetch.Response(dismissAction: request.dismissAction)
          self.presenter?.hasCreated(response: response)
        }
      case .failure(let err):
        print(err)
      }
    }
  }
}
