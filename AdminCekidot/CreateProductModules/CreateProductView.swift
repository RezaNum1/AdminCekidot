//
//  CreateProductView.swift
//  AdminCekidot
//
//  Created by Reza Harris on 28/11/21.
//

import SwiftUI

struct CreateProductView: View {
//  @State var product = Product(name: "Jif", imageSource: "Google", category: "Dairy", allergen: "Milk, Peanut", productMass: "23", servingSize: "2", calories: "23", carbs: "12", fat: "2", protein: "3", saturates: "1", sodium: "3", sugar: "1", ingredientEng: "Sugar, Salt", ingredientID: "Gula, Garam")
  @State var product = Product()
  @State private var image: UIImage?
  @State private var shouldShowImagePicker = false
  
  @ObservedObject var createProductPresenter = CreateProductPresenter()
  var createProductInteractor = CreateProductInteractor()
  
  @Environment(\.dismiss) var dismiss
  
  
  // MARK: Picker
  @State var isPickerShow = false
  @State var selectedIndex = 0
  @State var pickerValue = ["Dairy", "Grains", "Snack", "Breads", "Condiments", "Frozen", "Packaged", "Beverages"]
  @State var selectedValue = "- Select Category -"
  
  @State var isBtnDisabled = true
  
  init() {
    createProductInteractor.presenter = createProductPresenter
  }
  
  var body: some View {
    ZStack {
      VStack {
        ScrollView {
          Group {
            TextFieldForm(title: "Name", placeHolder: "Ex: Jif Peanut..", value: $product.name.bound)
            HStack {
              Text("Category")
                .withCustomTextModifier(color: .black, size: 17, weight: .medium, design: .default)
              Spacer()
              HStack(alignment: .firstTextBaseline) {
                Text(product.category.bound.isEmpty ? "- Select Category -" : product.category.bound)
                  .withCustomTextModifier(color: .blue, size: 18, weight: .medium, design: .default)
                  .onTapGesture {
                    Utilities.shared.endEditing()
                    selectedIndex = pickerValue.firstIndex(of: product.category.bound) ?? 0
                    isPickerShow.toggle()
                  }
              }
            }
            .padding([.leading, .trailing], 16)
//            VStack(alignment: .leading) {
//              TextFieldForm(title: "Category", placeHolder: "Ex: dairy..", value: $product.category.bound)
//              Text("(Choose One: grains, dairy, snacks, breads, condiments, frozen, packaged, beverages)")
//                .fontWeight(.medium)
//                .font(.system(size: 10))
//                .padding(.leading, 20)
//                .padding(.bottom, 15)
//            }
            
            
            TextFieldForm(title: "Allergen", placeHolder: "Ex: Milk, Peanut, TreeNut..", value: $product.allergen.bound)
            
            TextFieldForm(title: "Product Mass", placeHolder: "Ex: 3.4..", value: $product.productMass.bound)
              .keyboardType(.numbersAndPunctuation)
            TextFieldForm(title: "Serving Size", placeHolder: "Ex: 3.3..",value: $product.servingSize.bound)
              .keyboardType(.numbersAndPunctuation)
          }
          
          Group {
            TextFieldForm(title: "Calories", placeHolder: "Ex: 1.1..", value: $product.calories.bound)
              .keyboardType(.numbersAndPunctuation)
            TextFieldForm(title: "Carbs", placeHolder: "Ex: 10..", value: $product.carbs.bound)
              .keyboardType(.numbersAndPunctuation)
            TextFieldForm(title: "Fats", placeHolder: "Ex: 5..", value: $product.fat.bound)
              .keyboardType(.numbersAndPunctuation)
          }
          Group {
            TextFieldForm(title: "Protein", placeHolder: "Ex: 10..", value: $product.protein.bound)
              .keyboardType(.numbersAndPunctuation)
            TextFieldForm(title: "Saturates", placeHolder: "Ex: 8..", value: $product.saturates.bound)
              .keyboardType(.numbersAndPunctuation)
            TextFieldForm(title: "Sodium", placeHolder: "Ex: 0.2..", value: $product.sodium.bound)
              .keyboardType(.numbersAndPunctuation)
          }
          Group {
            TextFieldForm(title: "Sugar", placeHolder: "Ex: 2..", value: $product.sugar.bound)
              .keyboardType(.numbersAndPunctuation)
            TextFieldForm(title: "Ingredient Eng", placeHolder: "Ex: Sugar, Salt..", value: $product.ingredientEng.bound)
            TextFieldForm(title: "Ingredient ID", placeHolder: "Ex: Gula, Garam..", value: $product.ingredientID.bound)
          }
          
          Section {
            VStack(alignment: .leading) {
              Text("Image")
                .fontWeight(.medium)
              Button(
                action: {
                  shouldShowImagePicker.toggle()
                },
                label: makeImageForChoosePhotosButton
              )
            }
            .padding()
          }
          
          TextFieldForm(title: "Image Source", placeHolder: "Ex: Google.com..", value: $product.imageSource.bound)
          CustomButton(buttonTitle: "Save Product", function: saveProduct, isDisable: $isBtnDisabled)
        }
      }
      .contentShape(Rectangle())
      .onTapGesture(perform: {
        isPickerShow = false
        Utilities.shared.endEditing()
      })
      
      if isPickerShow {
        VStack {
          Spacer()
          PickerView(title: "Hello", selectedIndex: $selectedIndex, arrayValue: $pickerValue, value: $product.category.bound.onChange(checkValue), showPicker: $isPickerShow)
        }
      }
      
      if createProductPresenter.isOnProgress {
        ProgressView()
      }
    }
    .disabled(createProductPresenter.isOnProgress ? true : false)
    .navigationBarTitle("Add Product")
    .sheet(isPresented: $shouldShowImagePicker) {
      ImagePicker(image: $image)
    }
  }
  
  func saveProduct() {
    createProductPresenter.isOnProgress = true
    product.image = image?.resized(withPercentage: 0.8)?.pngData()
    let request = CreateProductModel.Fetch.Request(products: product, dismissAction: dismiss)
    createProductInteractor.createProduct(request: request)
  }
  
  func checkValue(val: String) {
    if product.category.bound.isEmpty {
      isBtnDisabled = true
    } else {
      isBtnDisabled = false
    }
  }

  
  @ViewBuilder
  private func makeImageForChoosePhotosButton() -> some View {
    image.map {
      Image(uiImage: $0)
        .renderingMode(.original)
        .resizable()
        .aspectRatio(contentMode: .fill)
    }
    
    if image == nil {
      HStack {
        Spacer()
        Image(systemName: "photo.on.rectangle")
        Text("Choose Photo")
        Spacer()
      }
      .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
      .withStatefulButtonTextViewModifier(isDisable: false)
      .padding()
    }
  }
}

struct CreateProductView_Previews: PreviewProvider {
  static var previews: some View {
    CreateProductView()
  }
}


//var id: UUID?
//var name: String?
//var active: Bool?
//var image: Data?
//var imageSource: String?
//var category: String?
//var allergen: [String]?
//var productMass: Int?
//var servingSize: Float?
//var calories: Float?
//var carbs: Float?
//var fat: Float?
//var protein: Float?
//var saturates: Float?
//var sodium: Float?
//var sugar: Float?
//var ingredientEng: String?
//var ingredientID: String?
//var createdAt: Date?
//var updatedAt: Date?


//case grains = "grains"
//case dairy = "dairy"
//case snacks = "snacks"
//case breads = "breads"
//case condiments = "condiments"
//case frozen = "frozen"
//case packaged = "packaged"
//case beverages = "beverages"
