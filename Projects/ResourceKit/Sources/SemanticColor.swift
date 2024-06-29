//
//  SemanticColor.swift
//  DesignSystem
//
//  Created by kimchansoo on 6/28/24.
//

import SwiftUI

public struct Color {
	public struct Text {
		public static let primary = ResourceKitAsset.PrimaryColor.neutral90.swiftUIColor
		public static let secondary = ResourceKitAsset.PrimaryColor.neutral70.swiftUIColor
		public static let tertiary = ResourceKitAsset.PrimaryColor.neutral60.swiftUIColor
		public static let assistive = ResourceKitAsset.PrimaryColor.neutral40.swiftUIColor
		public static let disabled = ResourceKitAsset.PrimaryColor.neutral30.swiftUIColor
		public static let inverse = ResourceKitAsset.PrimaryColor.common100.swiftUIColor
		public static let brand = ResourceKitAsset.PrimaryColor.orange100.swiftUIColor
	}
	
	public struct Icon {
		public static let primary = ResourceKitAsset.PrimaryColor.neutral90.swiftUIColor
		public static let secondary = ResourceKitAsset.PrimaryColor.neutral70.swiftUIColor
		public static let tertiary = ResourceKitAsset.PrimaryColor.neutral60.swiftUIColor
		public static let assistive = ResourceKitAsset.PrimaryColor.neutral40.swiftUIColor
		public static let disabled = ResourceKitAsset.PrimaryColor.neutral30.swiftUIColor
		public static let inverse = ResourceKitAsset.PrimaryColor.common100.swiftUIColor
		public static let brand = ResourceKitAsset.PrimaryColor.orange100.swiftUIColor
	}
	
	public struct Border {
		public static let primary = ResourceKitAsset.PrimaryColor.neutral90.swiftUIColor
		public static let secondary = ResourceKitAsset.PrimaryColor.neutral20.swiftUIColor
		public static let assistive = ResourceKitAsset.PrimaryColor.neutral10.swiftUIColor
	}
	
	public struct Background {
		public static let primary = ResourceKitAsset.PrimaryColor.neutral90.swiftUIColor
		public static let assistive = ResourceKitAsset.PrimaryColor.neutral10.swiftUIColor
		public static let dimmer = Color.Text.primary.opacity(40)
		public static let brand = ResourceKitAsset.PrimaryColor.orange100.swiftUIColor
		public static let brandassistive = ResourceKitAsset.PrimaryColor.orange10.swiftUIColor
		public static let white = ResourceKitAsset.PrimaryColor.common100.swiftUIColor
	}
	
	public struct Skeleton {
		public static let primary = ResourceKitAsset.PrimaryColor.neutral10.swiftUIColor
		public static let secondary = ResourceKitAsset.PrimaryColor.neutral20.swiftUIColor
	}
	
}
