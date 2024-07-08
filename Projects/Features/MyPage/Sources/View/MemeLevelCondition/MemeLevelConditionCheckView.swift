//
//  MemeLevelConditionCheckView.swift
//  MyPage
//
//  Created by 장혜령 on 2024/07/03.
//

import SwiftUI
import ResourceKit
import DesignSystem

struct MemeLevelConditionCheckView: View {
  let memeLevel: MemeLevelType
  
  private var pregressStepLevel: CGFloat {
    return CGFloat(memeLevel.rawValue - 1)
  }
  
  private let horizantalPadding: CGFloat = 36.0
  private let checkImageSize: CGSize = CGSize(width: 24, height: 24)
  
  var body: some View {
    VStack {
      progressDottedLine
      stepCheckView
        .offset(x: 0, y: -22)
    }
    .padding(.top, 40)
    .padding(.horizontal, 20)
    .padding(.bottom, 30)
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
        levelStepView(type: type)
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

