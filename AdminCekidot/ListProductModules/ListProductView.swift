//
//  ListProductView.swift
//  AdminCekidot
//
//  Created by Reza Harris on 27/11/21.
//

import SwiftUI

struct ListProductView: View {
  @State var products: [Product] = []
  @ObservedObject var listProductPresenter = ListProductPresenter()
  var listProductInteractor = ListProductInteractor()
  @State var isExecuted = false
  @State var isShowingAlert = false
  @State var indexSet: IndexSet = IndexSet()
  
  init() {
    listProductInteractor.presenter = listProductPresenter
  }
  
  var body: some View {
    ZStack {
      NavigationView {
        ZStack(alignment: .bottomTrailing) {
          List {
            ForEach(listProductPresenter.products, id: \.self) { product in
              makeItemView(from: product)
            }.onDelete(perform: deleteProduct)
          }
          .overlay(listProductPresenter.products.isEmpty ? Text("Add a product using the button below") : nil, alignment: .center)
          
          NavigationLink(destination: CreateProductView()) {
            HStack {
              Image(systemName: "plus.circle.fill")
              Text("Add Product")
            }
            .onAppear {
              if !isExecuted {
                listProductPresenter.isDone = false
                listProductInteractor.fetch()
                isExecuted = true
              }
              
            }
            .onDisappear {
              isExecuted = false
            }
          }
          .buttonStyle(ActionButtonBackgroundStyle())
          .padding(.bottom, 20)
        }
        .disabled(listProductPresenter.isDone ? false : true)
        .navigationBarTitle("Product")
      }
      
      if !listProductPresenter.isDone {
        ProgressView()
      }
    }
    .alert(isPresented:$isShowingAlert) {
      Alert(
        title: Text("Are you sure you want to non activate this item?"),
        message: Text("This item will be hidden on Cekidot and users cannot access it."),
        primaryButton: .destructive(Text("Delete")) {
          removePeriods(at: indexSet)
        },
        secondaryButton: .cancel()
      )
    }
    .onAppear {
      listProductPresenter.isDone = false
      listProductInteractor.fetch()
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
  
  func removePeriods(at offsets: IndexSet) {
    listProductPresenter.products =
    listProductPresenter.products.enumerated().filter { (i, item) -> Bool in
      let removed = offsets.contains(i)
      if removed {
        let request = ListProductModel.Fetch.RequestRemoveItem(product: item)
        listProductInteractor.removeItem(request: request)
      }
      return !removed
    }.map { $0.1 }
  }
  
  private func deleteProduct(at indices: IndexSet) {
    isShowingAlert = true
    indexSet = indices
  }
}

struct ListProductView_Previews: PreviewProvider {
  static var previews: some View {
    ListProductView()
  }
}
