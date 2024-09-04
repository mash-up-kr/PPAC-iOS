//
//  MemeLevelType.swift
//  MyPage
//
//  Created by 장혜령 on 2024/06/30.
//

import Foundation
import SwiftUI
import ResourceKit

public enum MemeLevelType: Int, CaseIterable, Identifiable, Comparable {
  public var id: Int { rawValue }
  
  case level1 = 1
  case level2 = 2
  case level3 = 3
  case level4 = 4
  
  public var speechBalloonText: String {
    let speechBalloonList = [
        "밈 폼 미쳤다",
        "밈 천재가 되",
        "완전 러키비키잖아~",
        "너 드립 좀 친다?",
        "하이하이!",
        "신나게 밈 흔들어~",
        "중꺾마!",
        "밈린이 라고할 뻔",
        "렛츠고 밈천재",
        "밈야호~"
    ]
    return speechBalloonList.randomElement() ?? ""
  }
  
  public var levelStepText: String {
    switch self {
    case .level1:
      return "밈 보기"
    case .level2:
      return "ㅋ 남기기"
    case .level3:
      return "밈 공유"
    case .level4:
      return "밈 저장"
    }
  }
  
  public var levelTitleText: String {
    switch self {
    case .level1:
      return "LV.1 호기심 많은 밈린이"
    case .level2:
      return "LV.2 은은하게 밈친자"
    case .level3:
      return "LV.3 입담 좋은 밈수저"
    case .level4:
      return "LV.4 독보적인 밈천재"
    }
  }
  
  public var levelConditionText: String {
    switch self {
    case .level1:
      return "밈 20번 보기"
    case .level2:
      return "ㅋㅋ반응 20번 남기기"
    case .level3:
      return "밈 20번 공유하기"
    case .level4:
      return "밈 20번 저장하기"
    }
  }
  
  public var levelCharacterImage: Image {
    switch self {
    case .level1:
      return ResourceKitAsset.Icon.level1Character.swiftUIImage
    case .level2:
      return ResourceKitAsset.Icon.level2Character.swiftUIImage
    case .level3:
      return ResourceKitAsset.Icon.level3Character.swiftUIImage
    case .level4:
      return ResourceKitAsset.Icon.level4Character.swiftUIImage
    }
  }
    
  public var levelBadgeImage: Image {
    switch self {
    case .level1:
      return ResourceKitAsset.Icon.level1.swiftUIImage
    case .level2:
      return ResourceKitAsset.Icon.level2.swiftUIImage
    case .level3:
      return ResourceKitAsset.Icon.level3.swiftUIImage
    case .level4:
      return ResourceKitAsset.Icon.level4.swiftUIImage
    }
  }
  
  // MARK: Comparable
  public static func < (lhs: MemeLevelType, rhs: MemeLevelType) -> Bool {
      return lhs.rawValue < rhs.rawValue
    }
}

// MARK: - levelState
/// 각 레벨에 대한 진행상태를 표시하기 위한 enum
enum LevelState {
  case inProgress // 레벨 진행중
  case notStarted // 레벨 시작 전
  case completed // 레벨 달성 완료
}
