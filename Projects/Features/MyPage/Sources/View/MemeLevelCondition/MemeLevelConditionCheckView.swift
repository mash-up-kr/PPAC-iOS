//
//  MemeLevelConditionCheckView.swift
//  MyPage
//
//  Created by 장혜령 on 2024/07/03.
//

import SwiftUI
import ResourceKit
import PPACUtil

struct MemeLevelConditionCheckView: View {
  let memeLevel: MemeLevelType
  
  private var pregressStepLevel: CGFloat {
    let level = memeLevel.rawValue
    let stepLevel = level > 1 ? level - 1 : 0
    return CGFloat(stepLevel)
  }
  
  private let horizantalPadding: CGFloat = 50.0
  private let checkImageSize: CGSize = CGSize(width: 24, height: 24)
  
  var highlightWidth: CGFloat {
    let levelOneStepWidth = (UIScreen.screenWidth - horizantalPadding * 2.0) / 3.0
    return levelOneStepWidth * pregressStepLevel
  }
  
  var body: some View {
    VStack {
      progressDottedLine
      stepCheckView
        .offset(x: 0, y: -20)
    }
    .padding(.top, 40)
    .padding(.horizontal, 20)
    .padding(.bottom, 30)
    .background {
      RoundedCorner(radius: 20, corners: [.bottomLeft, .bottomRight])
        .stroke(Color.Border.tertiary, lineWidth: 1, fill: Color.Background.white)
    }
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
      DottedLine()
        .stroke(style: StrokeStyle(lineWidth: 1.5, dash: [5]))
        .frame(height: 1)
        .foregroundColor(Color.gray)
        
      DottedLine()
        .stroke(style: StrokeStyle(lineWidth: 1.5, dash: [5]))
        .frame(width: highlightWidth, height: 1)
        .foregroundColor(Color.Background.brand)
    }
    .padding(.horizontal, horizantalPadding)
  }
  
  var stepCheckView: some View {
    HStack {
      ForEach(MemeLevelType.allCases) { type in
        levelStepView(type: type)
        if type != .level4 {
          Spacer()
        }
      }
    }
    .frame(width: .infinity)
  }
}

struct levelStepView: View {
  let type: MemeLevelType
  
  var body: some View {
    VStack(alignment: .center, spacing: 10) {
      stepCheckImageView
      stepDescriptionChip
    }
  }
  
  var stepCheckImageView: some View {
    ZStack {
      ResourceKitAsset.Icon.levelcheck.swiftUIImage
        .frame(width: 20, height: 20, alignment: .center)
      Circle()
        .foregroundStyle(Color.Background.assistive)
        .frame(width: 20, height: 20, alignment: .center)
      Circle()
        .foregroundStyle(Color.Text.assistive)
        .frame(width: 8, height: 8, alignment: .center)
    }
    .frame(width: 24, height: 24, alignment: .center)
  }
  
  var stepDescriptionChip: some View {
    Text(type.levelStepText)
      .foregroundStyle(Color.Text.secondary)
      .font(Font.Body.Small.semiBold)
      .padding(.vertical, 5)
      .padding(.horizontal, 10)
      .background {
        RoundedRectangle(cornerRadius: 25, style: .continuous)
          .foregroundStyle(Color.Background.assistive)
      }
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
  MemeLevelConditionCheckView(memeLevel: .level3)
}

