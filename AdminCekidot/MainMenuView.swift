//
//  MainMenuView.swift
//  AdminCekidot
//
//  Created by Reza Harris on 29/11/21.
//

import SwiftUI

struct MainMenuView: View {
  var body: some View {
    TabView {
      ListProductView()
        .tabItem {
          Label("Active Product", systemImage: "list.dash")
        }
      
      ListNonActiveProductView()
        .tabItem {
          Label("Non-Active Product", systemImage: "eye.slash.fill")
        }
    }
  }
}

struct MainMenuView_Previews: PreviewProvider {
  static var previews: some View {
    MainMenuView()
  }
}
