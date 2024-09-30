//
//  MultipartRequestable.swift
//  PPACNetwork
//
//  Created by 장혜령 on 9/27/24.
//

import Foundation
import Alamofire

public protocol MultipartRequestable: Requestable {
  var formData: MultipartFormData { get }
  var multipartFormData: Alamofire.MultipartFormData { get }
}
