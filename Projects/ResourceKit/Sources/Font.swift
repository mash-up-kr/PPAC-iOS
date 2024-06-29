//
//  Font.swift
//  ResourceKit
//
//  Created by kimchansoo on 6/28/24.
//  Copyright © 2024 ppac.farmeme. All rights reserved.
//

import SwiftUI

public struct Font {
	public struct Weight {
		public static let bold = ResourceKitFontFamily.Pretendard.bold.swiftUIFont(size: 15)
		public static let semiBold = ResourceKitFontFamily.Pretendard.semiBold.swiftUIFont(size: 15)
		public static let medium = ResourceKitFontFamily.Pretendard.regular.swiftUIFont(size: 15)
	}
	
	public struct Heading {
		public static let large = ResourceKitFontFamily.Pretendard.bold.swiftUIFont(size: 24)
		public static let medium = ResourceKitFontFamily.Pretendard.bold.swiftUIFont(size: 20)
		public static let small = ResourceKitFontFamily.Pretendard.regular.swiftUIFont(size: 18)
	}
	
	public struct Body {
		public static let xlarge = ResourceKitFontFamily.Pretendard.bold.swiftUIFont(size: 16)
		public static let large = ResourceKitFontFamily.Pretendard.bold.swiftUIFont(size: 15)
		public static let medium = ResourceKitFontFamily.Pretendard.regular.swiftUIFont(size: 14)
		public static let small = ResourceKitFontFamily.Pretendard.regular.swiftUIFont(size: 13)
		public static let xsmall = ResourceKitFontFamily.Pretendard.regular.swiftUIFont(size: 12)
		
	}
}
