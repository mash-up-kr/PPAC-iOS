//
//  SemanticColor.swift
//  DesignSystem
//
//  Created by kimchansoo on 6/28/24.
//

import Foundation

public struct Color {
	public struct Text {
		public static let primary = ResourceKitAsset.neutral90.swiftUIColor
		public static let secondary = ResourceKitAsset.neutral70.swiftUIColor
		public static let tertiary = ResourceKitAsset.neutral60.swiftUIColor
		public static let assistive = ResourceKitAsset.neutral40.swiftUIColor
		public static let disabled = ResourceKitAsset.neutral30.swiftUIColor
		public static let inverse = ResourceKitAsset.common100.swiftUIColor
		public static let brand = ResourceKitAsset.orange100.swiftUIColor
	}
	
	public struct Icon {
		public static let primary = ResourceKitAsset.neutral90.swiftUIColor
		public static let secondary = ResourceKitAsset.neutral70.swiftUIColor
		public static let tertiary = ResourceKitAsset.neutral60.swiftUIColor
		public static let assistive = ResourceKitAsset.neutral40.swiftUIColor
		public static let disabled = ResourceKitAsset.neutral30.swiftUIColor
		public static let inverse = ResourceKitAsset.common100.swiftUIColor
		public static let brand = ResourceKitAsset.orange100.swiftUIColor
	}
	
	public struct Border {
		public static let primary = ResourceKitAsset.neutral90.swiftUIColor
		public static let secondary = ResourceKitAsset.neutral20.swiftUIColor
		public static let assistive = ResourceKitAsset.neutral10.swiftUIColor
	}
	
	public struct Background {
		public static let primary = ResourceKitAsset.neutral90.swiftUIColor
		public static let assistive = ResourceKitAsset.neutral10.swiftUIColor
		public static let dimmer = Color.Text.primary.opacity(40)
		public static let brand = ResourceKitAsset.orange100.swiftUIColor
		public static let brandassistive = ResourceKitAsset.orange10.swiftUIColor
		public static let white = ResourceKitAsset.common100.swiftUIColor
	}
	
	public struct Skeleton {
		public static let primary = ResourceKitAsset.neutral10.swiftUIColor
		public static let secondary = ResourceKitAsset.neutral20.swiftUIColor
	}
	
}
