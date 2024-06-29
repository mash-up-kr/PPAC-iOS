//
//  MemeLevelConditionView.swift
//  MyPage
//
//  Created by 장혜령 on 2024/06/29.
//

import SwiftUI
import ResourceKit

struct MemeLevelConditionView: View {
  let conditionCount: Int
  
  var body: some View {
    VStack {
      MemeLevelConditionInfoView(conditionCount: conditionCount)
        .frame(width: .infinity, height: 87)
        .foregroundStyle(Color.red)
      divider
        .foregroundStyle(Color.Background.white)
        .frame(width: .infinity, height: 100)
        .offset(x: 0, y: -5)
    }
    .background {
      RoundedRectangle(cornerRadius: 25, style: .circular)
        .stroke(Color.Border.secondary, lineWidth: 1, fill: Color.Background.assistive)
        .frame(width: .infinity, height: 200)
    }
    .padding(EdgeInsets(top: 16, leading: 20, bottom: 40, trailing: 20))
    
  }
  
  var divider: some View {
    Rectangle()
      .frame(width: .infinity, height: 2)
      .foregroundStyle(Color.Border.secondary)
  }
  
  var memeCountChipView: some View {
    HStack {
      Text("\(conditionCount)")
        .foregroundStyle(Color.Text.brand)
        .padding(.leading, 5)
      Text("/20")
        .foregroundStyle(Color.Text.tertiary)
        .offset(x: -8, y: 0)
    }.background {
      RoundedRectangle(cornerRadius: 30, style: .continuous)
        .foregroundStyle(Color.Background.white)
        .frame(width: 56, height: 30)
    }
    .padding(.vertical, 5)
    .padding(.horizontal, 10)
  }
}

struct MemeLevelConditionInfoView: View {
  let conditionCount: Int
  
  var body: some View {
    HStack(alignment: .top, spacing: 0) {
      confitionInfoView
      Spacer()
      countChipView
    }
    .padding(EdgeInsets(top: 30, leading: 20, bottom: 20, trailing: 0))
  }
  
  var confitionInfoView: some View {
    VStack(alignment: .leading, spacing: 4) {
      titleLabel
      descriptionLabel
    }
  }
  
  var countChipView: some View {
    HStack {
      Text("\(conditionCount)")
        .foregroundStyle(Color.Text.brand)
        .padding(.leading, 5)
      Text("/20")
        .foregroundStyle(Color.Text.tertiary)
        .offset(x: -8, y: 0)
    }.background {
      RoundedRectangle(cornerRadius: 30, style: .continuous)
        .foregroundStyle(Color.Background.white)
        .frame(width: 56, height: 30)
    }
    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
  }
  
  var titleLabel: some View {
    Text("다음 레벨 달성 조건")
      .foregroundStyle(Color.Text.tertiary)
      .font(ResourceKitFontFamily.Pretendard.semiBold.swiftUIFont(size: 17))
  }
  
  var descriptionLabel: some View {
    Text("밈 20번 공유하기")
      .foregroundStyle(Color.Text.primary)
      .font(ResourceKitFontFamily.Pretendard.bold.swiftUIFont(size: 24))
  }
}

struct MemeLevelCheckView: View {
  var body: some View {
    ZStack {
      Line()
        .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
        .frame(width: 100, height: 1, alignment: .bottom)
      HStack {
        ForEach(MemeLevelType.allCases) {
          levelStepView(type: $0)
        }
      }
    }
  }
}

struct StepCheckView: View {
  let memeLevel: MemeLevelType
  
  var body: some View {
    ZStack {
      dotLineView
      HStack {
        ForEach(MemeLevelType.allCases) { level in
          stepCheckImageView
          
        }
      }
    }
    .frame(width: .infinity, height: 24, alignment: .center)
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
  
  
  var dotLineView: some View {
    HStack {
      ForEach(0..<3, id: \.self) { index in
        let color = memeLevel.rawValue > index ? Color.Background.brand : Color.Background.primary
        Line()
          .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
          .foregroundStyle(color)
          .frame(width: 150, height: 1, alignment: .bottom)
      }
    }
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
      .font(ResourceKitFontFamily.Pretendard.semiBold.swiftUIFont(size: 17))
      .padding(.vertical, 5)
      .padding(.horizontal, 10)
      .background {
        RoundedRectangle(cornerRadius: 25, style: .continuous)
          .foregroundStyle(Color.Background.assistive)
      }
  }
}
struct Line: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    path.move(to: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x: rect.width, y: 0))
    return path
  }
}

#Preview {
  MemeLevelConditionView(conditionCount: 10)
  //MemeLevelConditionView(conditionCount: 10)
}
