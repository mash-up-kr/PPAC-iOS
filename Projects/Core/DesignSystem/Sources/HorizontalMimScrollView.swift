//
//  HorizontalMimScrollView.swift
//  DesignSystem
//
//  Created by 리나 on 2024/06/29.
//

import SwiftUI
import ResourceKit

public protocol HorizontalMimItemProtocol: Hashable { }

public protocol HorizontalMimItemViewProtocol: View {
  associatedtype Item: HorizontalMimItemProtocol
  init(item: Item)
}

public struct HorizontalMimScrollView<Item: HorizontalMimItemProtocol, ItemView: HorizontalMimItemViewProtocol>: View where ItemView.Item == Item {
  @Binding public var items: [Item]
  
  public init(items: Binding<[Item]>) {
    self._items = items
  }
  
  public var body: some View {
    ScrollView(.horizontal) {
      LazyHStack(spacing: 10) {
        ForEach(items, id: \.self) { item in
          ItemView(item: item)
        }
        .listStyle(.plain)
      }
    }
    .contentMargins(20)
    .scrollIndicators(.hidden)
    .frame(height: 90)
  }
}
