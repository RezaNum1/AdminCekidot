//
//  ProductItem.swift
//  AdminCekidot
//
//  Created by Reza Harris on 27/11/21.
//

import SwiftUI

struct ProductItem: View {
  let id: String?
  let name: String?
  let image: UIImage?

  var body: some View {
    HStack(spacing: 16) {
      image.map {
        Image(uiImage: $0)
          .renderingMode(.original)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 80, height: 80)
          .cornerRadius(4)
          .padding(.vertical)
      }

      VStack(alignment: .leading) {
        id.map {
          Text($0)
            .font(.headline)
        }
        name.map {
          Text($0)
            .font(.subheadline)
        }
      }
    }
  }
}

//struct ProductItem_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductItem(id: , name: <#T##String?#>, image: <#T##UIImage?#>)
//    }
//}
