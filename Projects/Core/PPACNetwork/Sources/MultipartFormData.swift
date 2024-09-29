//
//  MultipartFormData.swift
//  PPACNetwork
//
//  Created by 장혜령 on 9/25/24.
//

import Foundation

enum EncodingCharacters {
  static let crlf = "\r\n"
}

struct BoundaryGenerator {
  
  enum BoundaryType {
    case initial, encapsulated, final
  }
  
  // MARK: - properties
  let boundary: String
  
  // MARK: - init
  init(boundary: String) {
    self.boundary = boundary
  }
  
  public func boundaryData(
    forBoundaryType boundaryType: BoundaryType
  ) -> String {
    let boundaryText: String
    
    switch boundaryType {
    case .initial:
      boundaryText = "--\(boundary)\(EncodingCharacters.crlf)"
    case .encapsulated:
      //boundaryText = "\(EncodingCharacters.crlf)--\(boundary)\(EncodingCharacters.crlf)"
      boundaryText = "--\(boundary)\(EncodingCharacters.crlf)"
    case .final:
      //boundaryText = "\(EncodingCharacters.crlf)--\(boundary)--\(EncodingCharacters.crlf)"
      boundaryText = "--\(boundary)--\(EncodingCharacters.crlf)"
    }
    
    return boundaryText
  }
}

public struct FormData {
  public var fieldName: String
  public var fileName: String
  public var mimeType: String
  public var fileData: Data
  
  public init(
    fieldName: String,
    fileName: String,
    mimeType: String,
    fileData: Data
  ) {
    self.fieldName = fieldName
    self.fileName = fileName
    self.mimeType = mimeType
    self.fileData = fileData
  }
}

public struct MultipartFormData {
  public typealias FormField = [String: String]
  
  private let boundary: String
  private let boundaryGenerator: BoundaryGenerator
  public var body = Data()
  
  public init(
    boundary: String = UUID().uuidString,
    formFields: FormField = [:],
    formData: FormData
  ) {
    self.boundary = boundary.replacingOccurrences(of: "-", with: "")
    self.boundaryGenerator = BoundaryGenerator(boundary: boundary)
    
    formFields.forEach {
      self.body.append(appendTextField(named: $0.key, value: $0.value))
    }
    
    self.body.append(appendFormData(formData: formData))
  }
  
  public var contentType: String {
    return "multipart/form-data; boundary=\(boundary)"
  }
  
  public mutating func appendFinalBoundary() {
    self.body.append(boundaryGenerator.boundaryData(forBoundaryType: .final))
  }
  
  public func finalize() -> Data {
    return body
  }
  
  public func appendTextField(named name: String, value: String) -> Data {
    var data = Data()
    data.append(boundaryGenerator.boundaryData(forBoundaryType: .encapsulated))
    data.append("Content-Disposition: form-data; name=\"\(name)\"\(EncodingCharacters.crlf)")
    data.append("\(value)\(EncodingCharacters.crlf)")
    return data
  }

  public func appendFormData(formData: FormData) -> Data {
    var data = Data()
    data.append(boundaryGenerator.boundaryData(forBoundaryType: .encapsulated))
    data.append("Content-Disposition: form-data; name=\"\(formData.fieldName)\"; filename=\"\(formData.fileName)\"\(EncodingCharacters.crlf)")
    data.append("Content-Type: \(formData.mimeType)\(EncodingCharacters.crlf)\(EncodingCharacters.crlf)")
    data.append(formData.fileData)
    debugPrint(formData.fileData)
    data.append(EncodingCharacters.crlf)
    return data
  }
}

extension Data {
  mutating func append(_ string: String) {
    if let data = string.data(using: .utf8) {
      debugPrint(string)
      self.append(data)
    }
  }
  
  mutating func appendLineBreak(times: Int = 1) {
      for _ in 0..<times {
        self.append(EncodingCharacters.crlf)
      }
    }
}
