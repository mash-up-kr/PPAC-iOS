//
//  Throttler.swift
//  PPACUtil
//
//  Created by 김종윤 on 9/25/24.
//

import Foundation

public class Throttler {
  private let interval: TimeInterval
  private var task: Task<Void, Never>?
  
  public init(seconds: TimeInterval) {
    self.interval = seconds
  }
  
  @MainActor
  public func throttle(action: @escaping () async -> Void) {
    // 기존의 예약된 작업이 있으면 취소
    task?.cancel()
    
    // 새로운 작업 생성
    task = Task { [weak self] in
      guard let self else { return }
      
      do {
        // 지정된 시간만큼 대기
        
        try await Task.sleep(nanoseconds: UInt64(self.interval * 1_000_000_000))
        
        await action()
      } catch {
        if Task.isCancelled {
            // 태스크가 취소되었으므로 아무 작업도 하지 않음
            return
        } else {
            print("Task error: \(error)")
        }
      }
    }
  }
  
  public func cancel() {
    task?.cancel()
  }
}
