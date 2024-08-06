//
//  MemeLevelConditionCheckView.swift
//  MyPage
//
//  Created by 장혜령 on 2024/07/03.
//

import SwiftUI
import ResourceKit
import DesignSystem
import Lottie

struct MemeLevelConditionCheckView: View {
  let level: MemeLevelType
  let conditionCount: Int
  
  private var pregressStepLevel: CGFloat {
    return CGFloat(level.rawValue - 1)
  }
  
  private let horizantalPadding: CGFloat = 36.0
  
  var body: some View {
    VStack {
      progressDottedLine
      stepCheckView
        .offset(x: 0, y: -22)
    }
    .padding(.top, 40)
    .padding(.horizontal, 20)
    .padding(.bottom, 10)
    .background {
      RoundedCorners(radius: 20, corners: [.bottomLeft, .bottomRight])
        .stroke(Color.Border.tertiary, lineWidth: 1, fill: Color.Background.white)
    }
    .padding(.horizontal, 20)
  }
  
  var progressStepCheckView: some View {
    VStack {
      progressDottedLine
      stepCheckView
        .offset(x: 0, y: -20)
    }
  }
  
  var progressDottedLine: some View {
    ZStack(alignment: .leading) {
      GeometryReader { geometry in
        let highlightWidth = getHighlightWidth(geometry.size.width)
        DottedLine()
          .stroke(style: StrokeStyle(lineWidth: 1.5, dash: [5]))
          .frame(height: 1)
          .foregroundColor(Color.gray)
        
        DottedLine()
          .stroke(style: StrokeStyle(lineWidth: 1.5, dash: [5]))
          .frame(width: highlightWidth, height: 1)
          .foregroundColor(Color.Background.brand)
      }
    }
    .frame(height: 2)
    .padding(.horizontal, horizantalPadding)
  }
  
  var stepCheckView: some View {
    HStack {
      ForEach(MemeLevelType.allCases) { type in
        levelStepView(
          levelType: type,
          currentLevel: level,
          conditionCount: conditionCount
        )
        if type != .level4 {
          Spacer()
        }
      }
    }
  }
  
  private func getHighlightWidth(_ viewWidth: CGFloat) -> CGFloat {
    let levelOneStepWidth = viewWidth / 3.0
    return levelOneStepWidth * pregressStepLevel
  }
  
}

struct levelStepView: View {
  let levelType: MemeLevelType
  let currentLevel: MemeLevelType
  let conditionCount: Int
  
  var levelState: LevelState {
    if currentLevel == .level4 && conditionCount > 20 {
      return .completed
    } else if levelType < currentLevel {
      return .completed
    } else if levelType == currentLevel {
      return .inProgress
    }
    return .notStarted
  }
 
  var isCompletedLevel: Bool {
    return levelState == .completed
  }
  
  var body: some View {
    VStack(alignment: .center, spacing: 10) {
      stepCheckImageView
      stepDescriptionChip
    }
  }
  
  var stepCheckImageView: some View {
    levelCircleView
    .frame(width: 24, height: 24, alignment: .center)
  }
  
  var stepDescriptionChip: some View {
    Text(levelType.levelStepText)
      .foregroundStyle(
        isCompletedLevel
        ? Color.Text.brand
        : Color.Text.secondary
      )
      .font(Font.Body.Small.semiBold)
      .padding(.vertical, 5)
      .padding(.horizontal, 10)
      .background {
        RoundedRectangle(cornerRadius: 25, style: .continuous)
          .foregroundStyle(
            isCompletedLevel
            ? Color.Background.brandassistive
            : Color.Background.assistive
          )
      }
  }

  var levelCircleView: some View {
    switch levelState {
    case .inProgress:
      AnyView(currentLevelCircleView)
    case .notStarted:
      AnyView(defaultCircleView)
    case .completed:
      AnyView(completedLevelCircleView)
    }
  }
  
  var completedLevelCircleView: some View {
    ResourceKitAsset.Icon.levelcheck.swiftUIImage
      .frame(width: 20, height: 20, alignment: .center)
  }
  
  var currentLevelCircleView: some View {
    ZStack {
      LottieView(animation: AnimationAsset.mypageLevelCircle.animation)
        .looping()
      defaultCircleView
    }
  }
  
  var defaultCircleView: some View {
    Circle()
      .foregroundStyle(Color.Text.assistive)
      .frame(width: 8, height: 8, alignment: .center)
  }
  
}

struct DottedLine: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    let dashLength: CGFloat = 5
    let dashSpace: CGFloat = 5
    var x: CGFloat = 0
    
    while x < rect.width {
      path.move(to: CGPoint(x: x, y: rect.midY))
      x += dashLength
      path.addLine(to: CGPoint(x: x, y: rect.midY))
      x += dashSpace
    }
    
    return path
  }
}

#Preview {
  MemeLevelConditionCheckView(level: .level1, conditionCount: 10)
}

