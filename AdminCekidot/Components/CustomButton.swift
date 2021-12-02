//
//  Button.swift
//  AdminCekidot
//
//  Created by Reza Harris on 28/11/21.
//

import SwiftUI

struct CustomButton: View {
  var buttonTitle: String
  var function: () -> Void
  @Binding var isDisable: Bool
  
  var body: some View {
    Button(action: {
      self.function()
    }, label: {
      Text(buttonTitle)
        .withCustomTextModifier(color: .white, size: 18, weight: .medium, design: .default)
        .withStatefulButtonTextViewModifier(isDisable: isDisable)
    }).withButtonViewModifier()
      .disabled(isDisable)
  }
}

//struct CustomButton_Previews: PreviewProvider {
//  static var previews: some View {
//    CustomButton(buttonTitle: "Test") {
//      print("Hello")
//    }
//  }
//}
