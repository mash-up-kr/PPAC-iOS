//
//  CategoryTagView.swift
//  DesignSystem
//
//  Created by 리나 on 2024/06/29.
//

import SwiftUI
import ResourceKit

// thanks to NamS
public struct CategoryTagView: View {
  @State public var categories: [String]

  public init(categories: [String]) {
    self.categories = categories
  }
  
  public var body: some View {
    ScrollView {
      CategoryTagLayout(verticalSpacing: 8, horizontalSpacing: 8) {
        ForEach(categories, id: \.self) { category in
          Text(category)
            .font(Font.Body.Medium.medium)
            .foregroundColor(Color.Text.primary)
            .padding(.horizontal, 16)
            .padding(.vertical, 9.5)
            .background(
              Capsule().foregroundStyle(Color.Background.assistive)
            )
        }
      }
    }
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        let cacheValue = categories
        categories = []
        categories = cacheValue
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
