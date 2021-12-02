//
//  ListNonActiveProductView.swift
//  AdminCekidot
//
//  Created by Reza Harris on 29/11/21.
//

import SwiftUI

struct ListNonActiveProductView: View {
  @State var products: [Product] = []
  @ObservedObject var listNonActiveProductPresenter = ListNonActiveProductPresenter()
  var listNonActiveProductInteractor = ListNonActiveProductInteractor()
  @State var isExecuted = false
  @State var isShowingAlert = false
  @State var indexSet: IndexSet = IndexSet()
  
  init() {
    listNonActiveProductInteractor.presenter = listNonActiveProductPresenter
  }
  
  var body: some View {
    ZStack {
      NavigationView {
        ZStack(alignment: .bottomTrailing) {
          List {
            ForEach(listNonActiveProductPresenter.products, id: \.self) { product in
              makeItemView(from: product)
            }.onDelete(perform: reActivateAlert)
          }
          .overlay(listNonActiveProductPresenter.products.isEmpty ? Text("Deleted Product is Empty") : nil, alignment: .center)
        }
        .disabled(listNonActiveProductPresenter.isDone ? false : true)
        .navigationBarTitle("Non-Active Product")
      }
      
      if !listNonActiveProductPresenter.isDone {
        ProgressView()
      }
    }
    .alert(isPresented:$isShowingAlert) {
      Alert(
        title: Text("Are you sure you want to non Re-Active this item?"),
        message: Text("This item will be shown on Cekidot and users can access it."),
        primaryButton: .destructive(Text("Re-Active")) {
          reActivatePeriods(at: indexSet)
        },
        secondaryButton: .cancel()
      )
    }
    .onAppear {
      listNonActiveProductPresenter.isDone = false
      listNonActiveProductInteractor.fetch()
      isExecuted = true
    }
    .onDisappear {
      isExecuted = false
    }
  }
  
  private func makeItemView(from product: Product) -> ProductItem {
    if let image = product.image {
      return ProductItem(
        id: product.id?.uuidString,
        name: product.name,
        image: image.isEmpty ? Utilities.shared.image(file: product.imageAssets) : image.uiImage
      )
    } else {
      return ProductItem(
        id: product.id?.uuidString,
        name: product.name,
        image: Utilities.shared.image(file: product.imageAssets)
      )
    }
  }
  
  func reActivatePeriods(at offsets: IndexSet) {
    listNonActiveProductPresenter.products =
    listNonActiveProductPresenter.products.enumerated().filter { (i, item) -> Bool in
      let removed = offsets.contains(i)
      if removed {
        let request = ListNonActiveProductModel.Fetch.RequestReActivateItem(product: item)
        listNonActiveProductInteractor.reActivateItem(request: request)
      }
      return !removed
    }.map { $0.1 }
  }
  
  private func reActivateAlert(at indices: IndexSet) {
    isShowingAlert = true
    indexSet = indices
  }
}

struct ListNonActiveProductView_Previews: PreviewProvider {
    static var previews: some View {
        ListNonActiveProductView()
    }
}
