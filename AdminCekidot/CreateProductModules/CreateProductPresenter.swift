//
//  CreateProductPresenter.swift
//  AdminCekidot
//
//  Created by Reza Harris on 28/11/21.
//

import Foundation

protocol CreateProductPresentationLogic {
  func hasCreated(response: CreateProductModel.Fetch.Response)
}

class CreateProductPresenter: ObservableObject, CreateProductPresentationLogic {
  
  @Published var isOnProgress = false
  
  func hasCreated(response: CreateProductModel.Fetch.Response) {
    isOnProgress = false
    response.dismissAction()
  }
}
