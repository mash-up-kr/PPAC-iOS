//
//  WebView.swift
//  DesignSystem
//
//  Created by 김종윤 on 8/2/24.
//

import SwiftUI
import WebKit

public struct WebView: UIViewRepresentable {
  let url: URL?
  
  public init(url: URL?) {
    self.url = url
  }
  
  public func makeUIView(context: Context) -> some WKWebView {
    return WKWebView()
  }
  
  public func updateUIView(_ webView: UIViewType, context: Context) {
    if let url = url {
      let request = URLRequest(url: url)
      webView.load(request)
    }
  }
}
