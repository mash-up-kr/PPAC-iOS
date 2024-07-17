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
  private var itemClickHandler: ((Item) -> ())?
  public init(items: Binding<[Item]>, itemClickHandler: ((Item) -> ())? = nil) {
    self._items = items
    self.itemClickHandler = itemClickHandler
  }
  
  public var body: some View {
    ScrollView(.horizontal) {
      LazyHStack(spacing: 10) {
        ForEach(items, id: \.self) { item in
          ItemView(item: item)
            .onTapGesture {
              itemClickHandler?(item)
            }
        }
        .listStyle(.plain)
      }
    }
    .contentMargins(20)
    .scrollIndicators(.hidden)
  }
}
