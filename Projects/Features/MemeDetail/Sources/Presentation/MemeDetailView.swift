//
//  MemeDetailView.swift
//  MemeDetail
//
//  Created by kimchansoo on 6/28/24.
//

import SwiftUI

import PPACModels

struct MemeDetailView: View {
  
  // MARK: - Properties
  private let meme: MemeDetail
  
  // MARK: - Initializers
  
  init(meme: MemeDetail) {
    self.meme = meme
  }
  
  // MARK: - UI
  
  var body: some View {
    MemeDetailCardView(meme: meme)
  }
}

#Preview {
  MemeDetailView(meme: .mock)
}
