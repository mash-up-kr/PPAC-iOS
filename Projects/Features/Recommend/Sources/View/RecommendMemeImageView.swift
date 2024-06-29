//
//  RecommendMemeImageView.swift
//  Recommend
//
//  Created by 김종윤 on 6/30/24.
//
import SwiftUI
import ResourceKit

struct RecommendMemeImageView: View {
  @State private var scrollIdx: Int?
  private var items: [Int] = [1,2,3,4,5]
  var isTagHidden: Bool = false
  
  init(isTagHidden: Bool) {
    self.isTagHidden = isTagHidden
  }
  
  public var body: some View {
    VStack {
      ScrollView(.horizontal) {
        LazyHStack {
          ForEach(items, id: \.self) { idx in
            RoundedRectangle(cornerRadius: 25)
              .foregroundStyle(Color.Background.brand)
              .frame(width: 270, height: 310)
              .overlay {
                RoundedRectangle(cornerRadius: 25)
                  .inset(by: 1)
                  .stroke(Color.Border.primary, lineWidth: 2)
              }
              .overlay {
                if let scrollIdx, scrollIdx != idx  {
                  RoundedRectangle(cornerRadius: 25)
                    .foregroundStyle(Color.Background.dimmer)
                }
              }
              .animation(.smooth, value: scrollIdx)
              .scrollTransition { content, phase in
                content
                  .scaleEffect(phase.isIdentity ? 1.0 : 0.9)
                  .blur(radius: phase.isIdentity ? 0 : 1)
              }
          }
        }
        .frame(height: 310)
        .scrollTargetLayout()
      }
      .scrollIndicators(.never)
      .scrollTargetBehavior(.viewAligned)
      .scrollPosition(id: $scrollIdx)
      .contentMargins(.horizontal, 60.0)
      .padding(.top, 36)
      .padding(.bottom, 20)
      .onAppear {
        self.scrollIdx = items.first
      }
      
      // 찬수가 만든 해쉬태그 사용하기
      if isTagHidden == false {
        HStack {
          Text("#슬픔")
          Text("#고양이")
          Text("#동물")
          Text("#눈물")
          Text("#억울")
          Text("#웃긴")
        }
      }
    }
  }
}
