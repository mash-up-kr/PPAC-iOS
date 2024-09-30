//
//  MemeEditEndPoint.swift
//  PPACData
//
//  Created by 장혜령 on 9/27/24.
//

import Foundation
import PPACNetwork
import UIKit
import Alamofire

enum MemeEditEndPoint: MultipartRequestable {
  case registerMeme(formData: FormData, title: String, source: String, keywordIds: [String])
  
  var httpMethod: PPACNetwork.HTTPMethod {
    switch self {
    case .registerMeme:
      return .post
    }
  }
  
  var path: String? {
    switch self {
    case .registerMeme:
      return "meme"
    }
  }
  
  var headers: [String : String]? {
    return nil
  }
  
  var parameter: HTTPRequestParameter? {
    return nil
  }
  
  var formData: PPACNetwork.MultipartFormData {
    switch self {
    case .registerMeme(let formData, let title, let source, let keywordIds):
      let formFields: [String : String] = ["title" : title,
                                           "source": source]
      print("=============== MultipartFormData ===============\n")
      var multipartFormData = PPACNetwork.MultipartFormData()
      
      formFields.forEach { key, value in
        multipartFormData.appendTextField(named: key, value: value)
      }
      
      for keyword in keywordIds {
        multipartFormData.appendTextField(named: "keywordIds[]", value: keyword)
      }
      
      multipartFormData.appendFormData(formData: formData)
      multipartFormData.appendFinalBoundary()
      print("=============== END ===============")
      return multipartFormData
    }
  }
  
  var multipartFormData: Alamofire.MultipartFormData {
    switch self {
    case .registerMeme(let formData, let title, let source, let keywordIds):
      
      let formFields: [String : String] = ["title" : title,
                                           "source": source]
      let multipartFormData = Alamofire.MultipartFormData()
      
      formFields.forEach { key, value in
        if let data = "\(value)".data(using: .utf8) {
            multipartFormData.append(data, withName: key)
        }
      }
      
      keywordIds.forEach { keywordId in
        if let data = "\(keywordId)".data(using: .utf8) {
            multipartFormData.append(data, withName: "keywordIds[]")
        }
      }
      
      multipartFormData.append(formData.fileData, withName: formData.fieldName, fileName: formData.fileName, mimeType: formData.mimeType)
      
      return multipartFormData
      
    }
  }
}
