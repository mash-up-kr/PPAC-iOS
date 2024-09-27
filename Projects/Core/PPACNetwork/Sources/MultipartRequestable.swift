//
//  MultipartRequestable.swift
//  PPACNetwork
//
//  Created by 장혜령 on 9/27/24.
//

import Foundation

public protocol MultipartRequestable: Requestable {
  var formData: MultipartFormData { get }
}
