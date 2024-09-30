//
//  KeywordsTagView.swift
//  DesignSystem
//
//  Created by 리나 on 2024/06/29.
//

import SwiftUI
import ResourceKit

// thanks to NamS
public struct KeywordsTagView: View {
  let keywordTags: [KeywordTag]
  var onTapHandler: ((String) -> ())?
  
  public init(keywordTags: [KeywordTag], onTapHandler: ((String) -> ())?) {
    self.keywordTags = keywordTags
    self.onTapHandler = onTapHandler
  }
  
  public var body: some View {
    ScrollView {
      FlowLayout(spacing: 8, lineSpacing: 8) {
        ForEach(keywordTags, id: \.self) { keywordTag in
          Text(keywordTag.name)
            .font(Font.Body.Medium.medium)
            .foregroundColor(
              keywordTag.isSelected
              ? Color.Text.brand
              : Color.Text.primary
            )
            .padding(.horizontal, 16)
            .padding(.vertical, 9.5)
            .background(
              Capsule().foregroundStyle(
                keywordTag.isSelected
                ? Color.Background.brandassistive
                : Color.Background.assistive
              )
            )
            .onTapGesture {
              onTapHandler?(keywordTag.name)
            }
        }
      }
    }
  }
}

struct FlowLayout: Layout {
  var spacing: CGFloat?
  var lineSpacing: CGFloat
  
  init(spacing: CGFloat? = nil, lineSpacing: CGFloat) {
    self.spacing = spacing
    self.lineSpacing = lineSpacing
  }
  
  struct Cache {
    var sizes: [CGSize] = []
    var spacing: [CGFloat] = []
  }
  
  func makeCache(subviews: Subviews) -> Cache {
    let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
    let spacing: [CGFloat] = subviews.indices.map { index in
      guard index != subviews.count - 1 else {
        return 0
      }
      
      return subviews[index].spacing.distance(
        to: subviews[index+1].spacing,
        along: .horizontal
      )
    }
    
    return Cache(sizes: sizes, spacing: spacing)
  }
  
  func sizeThatFits(
    proposal: ProposedViewSize,
    subviews: Subviews,
    cache: inout Cache
  ) -> CGSize {
    var totalHeight = 0.0
    var totalWidth = 0.0
    
    var lineWidth = 0.0
    var lineHeight = 0.0
    
    for index in subviews.indices {
      if lineWidth + cache.sizes[index].width > proposal.width ?? 0 {
        totalHeight += lineHeight + lineSpacing // 줄 간격 추가
        lineWidth = cache.sizes[index].width
        lineHeight = cache.sizes[index].height
      } else {
        lineWidth += cache.sizes[index].width + (spacing ?? cache.spacing[index])
        lineHeight = max(lineHeight, cache.sizes[index].height)
      }
      
      totalWidth = max(totalWidth, lineWidth)
    }
    
    totalHeight += lineHeight
    
    return .init(width: totalWidth, height: totalHeight)
  }
  
  func placeSubviews(
    in bounds: CGRect,
    proposal: ProposedViewSize,
    subviews: Subviews,
    cache: inout Cache
  ) {
    var lineX = bounds.minX
    var lineY = bounds.minY
    var lineHeight: CGFloat = 0
    
    for index in subviews.indices {
      if lineX + cache.sizes[index].width > (proposal.width ?? 0) {
        lineY += lineHeight + lineSpacing // 줄 간격 추가
        lineHeight = 0
        lineX = bounds.minX
      }
      
      let position = CGPoint(
        x: lineX + cache.sizes[index].width / 2,
        y: lineY + cache.sizes[index].height / 2
      )
      
      lineHeight = max(lineHeight, cache.sizes[index].height)
      lineX += cache.sizes[index].width + (spacing ?? cache.spacing[index])
      
      subviews[index].place(
        at: position,
        anchor: .center,
        proposal: ProposedViewSize(cache.sizes[index])
      )
    }
  }
}
