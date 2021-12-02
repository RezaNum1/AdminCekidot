//
//  GeneralProductWorker.swift
//  AdminCekidot
//
//  Created by Reza Harris on 27/11/21.
//

import Foundation
import CloudKit
import UIKit

class GeneralProductWorker {
  struct RecordType {
    static let product = "CD_Product"
  }
  
  enum CloudKitHelperError: Error {
    case recordFailure
    case recordIDFailure
    case castFailure
    case cursorFailure
  }
  
  static var shared = GeneralProductWorker()
  
  func fetchActiveProduct(completion: @escaping (Result<[Product], Error>) -> ()) {
    var products: [Product] = []
//    let pred = NSPredicate(value: true)
    let pred = NSPredicate(format: "CD_active == %@", NSNumber(1))
    let sort = NSSortDescriptor(key: "creationDate", ascending: false)
    let query = CKQuery(recordType: RecordType.product, predicate: pred)
    query.sortDescriptors = [sort]
    
    let operation = CKQueryOperation(query: query)
    operation.desiredKeys = [
      "CD_id",
      "CD_name",
      "CD_active",
      "CD_allergen",
      "CD_calories",
      "CD_carbs",
      "CD_category",
      "CD_fat",
      "CD_image",
      "CD_image_ckAsset",
      "CD_imageSource",
      "CD_ingredientEng",
      "CD_ingredientID",
      "CD_productMass",
      "CD_protein",
      "CD_saturates",
      "CD_servingSize",
      "CD_sodium",
      "CD_sugar",
      "CD_createdAt",
      "CD_createdAt",
      "CD_updatedAt"
    ]
    operation.resultsLimit = 50
    
    operation.recordFetchedBlock = { record in
      products.append(Product(id: record["CD_id"] as? UUID, recordID: record.recordID, name: record["CD_name"], active: record["CD_active"]!, image: record["CD_image"] as? Data, imageAssets: record["CD_image_ckAsset"] as? CKAsset, imageSource: record["CD_imageSource"], category: record["CD_category"], allergen: Utilities.shared.convertArrayToStr(value: record["CD_allergen"] as? [String]), productMass: record["CD_productMass"], servingSize: record["CD_servingSize"], calories: record["CD_calories"], carbs: record["CD_carbs"], fat: record["CD_fat"], protein: record["CD_protein"], saturates: record["CD_saturates"], sodium: record["CD_sodium"], sugar: record["CD_sugar"], ingredientEng: record["CD_ingredientEng"], ingredientID: record["CD_ingredientID"], createdAt: record["CD_createdAt"], updatedAt: record["CD_updatedAt"]))
    }
    
    operation.completionBlock = {
      completion(.success(products))
    }
    
    operation.queryCompletionBlock = { (_, err) in
      DispatchQueue.main.async {
        if let err = err {
          completion(.failure(err))
          return
        }
      }
    }
    
    CKContainer(identifier: "iCloud.com.rezz.PlanEat").publicCloudDatabase.add(operation)
  }
  
  func fetchNonActiveProduct(completion: @escaping (Result<[Product], Error>) -> ()) {
    var products: [Product] = []
//    let pred = NSPredicate(value: true)
    let pred = NSPredicate(format: "CD_active == %@", NSNumber(0))
    let sort = NSSortDescriptor(key: "creationDate", ascending: false)
    let query = CKQuery(recordType: RecordType.product, predicate: pred)
    query.sortDescriptors = [sort]
    
    let operation = CKQueryOperation(query: query)
    operation.desiredKeys = [
      "CD_id",
      "CD_name",
      "CD_active",
      "CD_allergen",
      "CD_calories",
      "CD_carbs",
      "CD_category",
      "CD_fat",
      "CD_image",
      "CD_image_ckAsset",
      "CD_imageSource",
      "CD_ingredientEng",
      "CD_ingredientID",
      "CD_productMass",
      "CD_protein",
      "CD_saturates",
      "CD_servingSize",
      "CD_sodium",
      "CD_sugar",
      "CD_createdAt",
      "CD_createdAt",
      "CD_updatedAt"
    ]
    operation.resultsLimit = 50
    
    operation.recordFetchedBlock = { record in
      products.append(Product(id: record["CD_id"] as? UUID, recordID: record.recordID, name: record["CD_name"], active: record["CD_active"]!, image: record["CD_image"] as? Data, imageAssets: record["CD_image_ckAsset"] as? CKAsset, imageSource: record["CD_imageSource"], category: record["CD_category"], allergen: Utilities.shared.convertArrayToStr(value: record["CD_allergen"] as? [String]), productMass: record["CD_productMass"], servingSize: record["CD_servingSize"], calories: record["CD_calories"], carbs: record["CD_carbs"], fat: record["CD_fat"], protein: record["CD_protein"], saturates: record["CD_saturates"], sodium: record["CD_sodium"], sugar: record["CD_sugar"], ingredientEng: record["CD_ingredientEng"], ingredientID: record["CD_ingredientID"], createdAt: record["CD_createdAt"], updatedAt: record["CD_updatedAt"]))
    }
    
    operation.completionBlock = {
      completion(.success(products))
    }
    
    operation.queryCompletionBlock = { (_, err) in
      DispatchQueue.main.async {
        if let err = err {
          completion(.failure(err))
          return
        }
      }
    }
    
    CKContainer(identifier: "iCloud.com.rezz.PlanEat").publicCloudDatabase.add(operation)
  }
  
  func save(item: Product, completion: @escaping (Result<Bool, Error>) -> ()) {
    let itemRecord = CKRecord(recordType: RecordType.product)
    itemRecord["CD_id"] = UUID().uuidString
    itemRecord["CD_name"] = item.name
    itemRecord["CD_active"] = item.active == true ? Int64(1) : Int64(0)
    
    itemRecord["CD_entityName"] = "Product"
    itemRecord["CD_calories"] = Double(item.calories!)
    itemRecord["CD_carbs"] = Double(item.carbs!)
    itemRecord["CD_category"] = item.category?.lowercased()
    itemRecord["CD_fat"] = Double(item.fat!)
//    itemRecord["CD_image"] = item.image
    itemRecord["CD_image_ckAsset"] = item.image?.uiImage?.toCKAsset(name: UUID().uuidString)
    itemRecord["CD_imageSource"] = item.imageSource
    itemRecord["CD_ingredientEng"] = item.ingredientEng
    itemRecord["CD_ingredientID"] = item.ingredientID
    itemRecord["CD_productMass"] = Int64(item.productMass!)
    itemRecord["CD_protein"] = Double(item.protein!)
    itemRecord["CD_saturates"] = Double(item.saturates!)
    itemRecord["CD_servingSize"] = Double(item.servingSize!)
    itemRecord["CD_sodium"] = Double(item.sodium!)
    itemRecord["CD_sugar"] = Double(item.sugar!)
    itemRecord["CD_createdAt"] = item.createdAt
    itemRecord["CD_updatedAt"] = item.updatedAt
    
    
        CKContainer(identifier: "iCloud.com.rezz.PlanEat").publicCloudDatabase.save(itemRecord) { (record, err) in
              DispatchQueue.main.async {
                  if let err = err {
                      completion(.failure(err))
                      return
                  }
                  guard let record = record else {
                      completion(.failure(CloudKitHelperError.recordFailure))
                      return
                  }
    
                  completion(.success(true))
              }
          }
  }
  
  func delete(product: Product, completion: @escaping (Result<Bool, Error>) -> ()) {
    guard let recordID = product.recordID else { return }
    CKContainer(identifier: "iCloud.com.rezz.PlanEat").publicCloudDatabase.fetch(withRecordID: recordID) { record, err in
      DispatchQueue.main.async {
        if let err = err {
            completion(.failure(err))
            return
        }
        guard let record = record else { return }
        record["CD_active"] = Int64(0)
        
        CKContainer(identifier: "iCloud.com.rezz.PlanEat").publicCloudDatabase.save(record) { (record, err) in
          DispatchQueue.main.async {
            if let err = err {
                completion(.failure(err))
                return
            }
            
            completion(.success(true))
          }
        }
      }
    }
  }
  
  func reActiveItem(product: Product, completion: @escaping (Result<Bool, Error>) -> ()) {
    guard let recordID = product.recordID else { return }
    CKContainer(identifier: "iCloud.com.rezz.PlanEat").publicCloudDatabase.fetch(withRecordID: recordID) { record, err in
      DispatchQueue.main.async {
        if let err = err {
            completion(.failure(err))
            return
        }
        guard let record = record else { return }
        record["CD_active"] = Int64(1)
        
        CKContainer(identifier: "iCloud.com.rezz.PlanEat").publicCloudDatabase.save(record) { (record, err) in
          DispatchQueue.main.async {
            if let err = err {
                completion(.failure(err))
                return
            }
            
            completion(.success(true))
          }
        }
      }
    }
  }
}


//    if let allergen = item.allergen {
//      let allergenArr = Utilities.shared.convertStrToArray(value: allergen)
//      let allergenData = Utilities.shared.stringArrayToData(stringArray: allergenArr)
//      let bytes: [UInt8] = [UInt8](allergenData!)
//      itemRecord["CD_allergen"] = bytes
//    }
