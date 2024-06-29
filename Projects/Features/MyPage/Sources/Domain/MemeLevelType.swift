//
//  MemeLevelType.swift
//  MyPage
//
//  Created by 장혜령 on 2024/06/30.
//

import Foundation

public enum MemeLevelType: Int, CaseIterable, Identifiable {
  public var id: Int { rawValue }
  
  case level1
  case level2
  case level3
  case level4
  
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
}
