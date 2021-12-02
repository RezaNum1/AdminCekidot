//
//  ButtonModifiers.swift
//  AdminCekidot
//
//  Created by Reza Harris on 28/11/21.
//

import Foundation
import SwiftUI

struct ButtonViewModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .frame(width: 275)
      .multilineTextAlignment(.center)
      .padding([.leading, .trailing], 5)
  }
}

struct StatefulButtonTextViewModifier: ViewModifier {
  var isDisable: Bool
  func body(content: Content) -> some View {
    content
      .frame(
        minWidth: 275,
        minHeight: 44
      )
      .background(isDisable ? Color.peGrayPick : Color.blue)
      .foregroundColor(.white)
      .cornerRadius(20)
  }
}

extension View {
  func withButtonViewModifier() -> some View {
    self.modifier(ButtonViewModifier())
  }
  
  func withStatefulButtonTextViewModifier(isDisable: Bool) -> some View {
    self.modifier(StatefulButtonTextViewModifier(isDisable: isDisable))
  }
}
