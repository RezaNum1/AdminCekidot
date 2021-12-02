//
//  TextFieldForm.swift
//  AdminCekidot
//
//  Created by Reza Harris on 28/11/21.
//

import SwiftUI

struct TextFieldForm: View {
  var title: String = ""
  var placeHolder: String = ""
  @Binding var value: String
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(title)
        .fontWeight(.medium)
      TextField("\(placeHolder)", text: $value)
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.blue, style: StrokeStyle(lineWidth: 1.0)))
    }
    .padding()
  }
}

struct TextFieldForm_Previews: PreviewProvider {
  static var previews: some View {
    TextFieldForm(title: "Test", value: .constant(""))
  }
}
