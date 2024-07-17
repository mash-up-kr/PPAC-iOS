//
//  HorizontalMememScrollView.swift
//  DesignSystem
//
//  Created by 리나 on 2024/06/29.
//

import SwiftUI
import ResourceKit

public protocol HorizontalMemeItemProtocol: Hashable { }

public protocol HorizontalMemeItemViewProtocol: View {
  associatedtype Item: HorizontalMemeItemProtocol
  init(item: Item)
}

public struct HorizontalMemeScrollView<Item: HorizontalMemeItemProtocol, ItemView: HorizontalMemeItemViewProtocol>: View where ItemView.Item == Item {
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
