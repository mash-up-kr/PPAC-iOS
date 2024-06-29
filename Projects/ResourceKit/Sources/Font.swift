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
		public struct Large {
			public static let bold = ResourceKitFontFamily.Pretendard.bold.swiftUIFont(size: 24)
			public static let semiBold = ResourceKitFontFamily.Pretendard.semiBold.swiftUIFont(size: 24)
			public static let medium = ResourceKitFontFamily.Pretendard.medium.swiftUIFont(size: 24)
		}
		
		public struct Medium {
			public static let bold = ResourceKitFontFamily.Pretendard.bold.swiftUIFont(size: 20)
			public static let semiBold = ResourceKitFontFamily.Pretendard.semiBold.swiftUIFont(size: 20)
			public static let medium = ResourceKitFontFamily.Pretendard.medium.swiftUIFont(size: 20)
		}
		
		public struct Small {
			public static let bold = ResourceKitFontFamily.Pretendard.bold.swiftUIFont(size: 18)
			public static let semiBold = ResourceKitFontFamily.Pretendard.semiBold.swiftUIFont(size: 18)
			public static let medium = ResourceKitFontFamily.Pretendard.medium.swiftUIFont(size: 18)
		}
	}
	
	public struct Body {
		
		public struct Xlarge {
			public static let bold = ResourceKitFontFamily.Pretendard.bold.swiftUIFont(size: 16)
			public static let semiBold = ResourceKitFontFamily.Pretendard.semiBold.swiftUIFont(size: 16)
			public static let medium = ResourceKitFontFamily.Pretendard.medium.swiftUIFont(size: 16)
		}
		
		public struct Large {
			public static let bold = ResourceKitFontFamily.Pretendard.bold.swiftUIFont(size: 15)
			public static let semiBold = ResourceKitFontFamily.Pretendard.semiBold.swiftUIFont(size: 15)
			public static let medium = ResourceKitFontFamily.Pretendard.medium.swiftUIFont(size: 15)
		}
		
		public struct Medium {
			public static let bold = ResourceKitFontFamily.Pretendard.bold.swiftUIFont(size: 14)
			public static let semiBold = ResourceKitFontFamily.Pretendard.semiBold.swiftUIFont(size: 14)
			public static let medium = ResourceKitFontFamily.Pretendard.medium.swiftUIFont(size: 14)
		}
		
		public struct Small {
			public static let bold = ResourceKitFontFamily.Pretendard.bold.swiftUIFont(size: 13)
			public static let semiBold = ResourceKitFontFamily.Pretendard.semiBold.swiftUIFont(size: 13)
			public static let medium = ResourceKitFontFamily.Pretendard.medium.swiftUIFont(size: 13)
		}
		
		public struct Xsmall {
			public static let bold = ResourceKitFontFamily.Pretendard.bold.swiftUIFont(size: 12)
			public static let semiBold = ResourceKitFontFamily.Pretendard.semiBold.swiftUIFont(size: 12)
			public static let medium = ResourceKitFontFamily.Pretendard.medium.swiftUIFont(size: 12)
		}		
	}
}
