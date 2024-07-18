//
//  MemeListEmptyView.swift
//  DesignSystem
//
//  Created by 장혜령 on 2024/07/15.
//

import SwiftUI
import ResourceKit

public struct MemeListEmptyView: View {
  let description: String
  
  public init(description: String) {
    self.description = description
  }
  
  public var body: some View {
    Text(description)
      .font(Font.Body.Large.medium)
      .foregroundStyle(Color.Text.assistive)
      .padding(.top, 50)
      .padding(.bottom, 102)
  }
}

