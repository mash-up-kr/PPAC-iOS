//
//  Throttler.swift
//  PPACUtil
//
//  Created by 김종윤 on 9/25/24.
//

import Foundation

public class Throttler {
  private var workItem: DispatchWorkItem?
  private var lastExecution: Date?
  private let queue: DispatchQueue
  private let interval: TimeInterval
  
  public init(seconds: TimeInterval, queue: DispatchQueue = DispatchQueue.main) {
    self.interval = seconds
    self.queue = queue
  }
  
  public func throttle(action: @escaping () -> Void) {
    // 기존의 예약된 작업이 있으면 취소
    workItem?.cancel()
    
    // 새로운 작업 생성
    workItem = DispatchWorkItem { [weak self] in
      self?.lastExecution = Date()
      action()
    }
    
    // 인터벌 후에 작업을 실행하도록 예약 (즉시 실행하지 않음)
    queue.asyncAfter(deadline: .now() + interval, execute: workItem!)
  }
  
  public func cancel() {
    workItem?.cancel()
  }
}
