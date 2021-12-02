//
//  Utilities.swift
//  AdminCekidot
//
//  Created by Reza Harris on 28/11/21.
//

import Foundation
import SwiftUI
import CloudKit

class Utilities {
  static let shared = Utilities()
  
  func endEditing() {
    UIApplication.shared.endEditing()
  }
  
  func convertStrToArray(value: String) -> [String]{
    if !value.isEmpty {
      let newString = value.components(separatedBy: ",")
      return newString
    }
    
    return []
  }
  
  func convertArrayToStr(value: [String]?) -> String {
    if let strVal = value {
      let newString = strVal.joined(separator: ",")
      return newString
    }
    return ""
  }
  
  func stringArrayToData(stringArray: [String]) -> Data? {
    return try? JSONSerialization.data(withJSONObject: stringArray, options: [])
  }
  
  func image(file: CKAsset?) -> UIImage? {
      if let file = file {
        if let url = file.fileURL {
          if let data = NSData(contentsOf: url) {
            return UIImage(data: data as Data)
          }
        }
      }
      return nil
  }
}
