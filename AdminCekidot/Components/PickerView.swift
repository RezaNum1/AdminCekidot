//
//  PickerView.swift
//  AdminCekidot
//
//  Created by Reza Harris on 30/11/21.
//

import SwiftUI

struct PickerView: View {
  var title: String
  @Binding var selectedIndex: Int
  @Binding var arrayValue: [String]
  @Binding var value: String
  @Binding var showPicker: Bool
  
  var body: some View {
    ZStack {
      Picker(selection: $selectedIndex.onChange(changeState), label: Text("")) {
        ForEach(0 ..< arrayValue.count) {
          Text(self.arrayValue[$0])
            .foregroundColor(.black)
        }
      }
      .pickerStyle(WheelPickerStyle())
      .padding()
    }
    .frame(height: 200)
    .background(Color.peGrayPick)
  }
  
  func changeState(_ newValue: Int) {
    value = arrayValue[selectedIndex]
    showPicker.toggle()
  }
}
