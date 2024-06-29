//
//  ViewModelType.swift
//  PPACUtil
//
//  Created by kimchansoo on 6/29/24.
//

import Foundation

public protocol ViewModelType {
  associatedtype Action
  associatedtype State
  
  var state: State { get }
  
  func dispatch(type: Action)
}
