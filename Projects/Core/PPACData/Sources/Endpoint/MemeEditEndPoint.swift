//
//  MemeEditEndPoint.swift
//  PPACData
//
//  Created by 장혜령 on 9/27/24.
//

import Foundation
import PPACNetwork
import UIKit

enum MemeEditEndPoint: MultipartRequestable {
  case registerMeme(formData: FormData, title: String, source: String, keywordIds: [String])
  
  var httpMethod: HTTPMethod {
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
  
  var formData: MultipartFormData {
    switch self {
    case .registerMeme(let formData, let title, let source, let keywordIds):
      let formFields: [String : String] = ["title" : title,
                                           "source": source]
      print("=============== MultipartFormData ===============\n")
      var multipartFormData = MultipartFormData(formFields: formFields, formData: formData)
      
      for keyword in keywordIds {
        multipartFormData.body.append(multipartFormData.appendTextField(named: "keywordIds[]", value: keyword))
      }
      multipartFormData.appendFinalBoundary()
      print("=============== END ===============")
      return multipartFormData
    }
  }
}
