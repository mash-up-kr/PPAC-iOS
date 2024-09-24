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
  public let keywordTags: [KeywordTag]
  var onTapHandler: ((String) -> ())?

  public init(keywordTags: [KeywordTag], onTapHandler: ((String) -> ())?) {
    self.keywordTags = keywordTags
    self.onTapHandler = onTapHandler
  }
  
  public var body: some View {
    ScrollView {
      CategoryTagLayout(verticalSpacing: 8, horizontalSpacing: 8) {
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

struct CategoryTagLayout: Layout {
  var verticalSpacing: CGFloat = 0
  var horizontalSpacing: CGFloat = 0
  
  func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) -> CGSize {
    CGSize(width: proposal.width ?? 0, height: cache.height)
  }
  
  func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) {
    var sumX: CGFloat = bounds.minX
    var sumY: CGFloat = bounds.minY
    
    for index in subviews.indices {
      let view = subviews[index]
      let viewSize = view.sizeThatFits(.unspecified)
      guard let proposalWidth = proposal.width else { continue }
      
      if (sumX + viewSize.width > proposalWidth) {
        sumX = bounds.minX
        sumY += viewSize.height
        sumY += verticalSpacing
      }
      
      let point = CGPoint(x: sumX, y: sumY)
      view.place(at: point, anchor: .topLeading, proposal: proposal)
      sumX += viewSize.width
      sumX += horizontalSpacing
    }
    
    if let firstViewSize = subviews.first?.sizeThatFits(.unspecified) {
      cache.height = sumY + firstViewSize.height
    }
  }
    
  struct Cache {
    var height: CGFloat
  }
  
  func makeCache(subviews: Subviews) -> Cache {
    return Cache(height: 0)
  }
  
  func updateCache(_ cache: inout Cache, subviews: Subviews) { }
}
