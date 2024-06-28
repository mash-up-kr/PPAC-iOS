//
//  SemanticColor.swift
//  DesignSystem
//
//  Created by kimchansoo on 6/28/24.
//

import Foundation

public struct Color {
    public struct Text {
        static let primary = DesignSystemAsset.neutral90.swiftUIColor
        static let secondary = DesignSystemAsset.neutral70.swiftUIColor
        static let tertiary = DesignSystemAsset.neutral60.swiftUIColor
        static let assistive = DesignSystemAsset.neutral40.swiftUIColor
        static let disabled = DesignSystemAsset.neutral30.swiftUIColor
        static let inverse = DesignSystemAsset.common100.swiftUIColor
        static let brand = DesignSystemAsset.orange100.swiftUIColor
    }
    
    public struct Icon {
        static let primary = DesignSystemAsset.neutral90.swiftUIColor
        static let secondary = DesignSystemAsset.neutral70.swiftUIColor
        static let tertiary = DesignSystemAsset.neutral60.swiftUIColor
        static let assistive = DesignSystemAsset.neutral40.swiftUIColor
        static let disabled = DesignSystemAsset.neutral30.swiftUIColor
        static let inverse = DesignSystemAsset.common100.swiftUIColor
        static let brand = DesignSystemAsset.orange100.swiftUIColor
    }
    
    public struct Border {
        static let primary = DesignSystemAsset.neutral90.swiftUIColor
        static let secondary = DesignSystemAsset.neutral20.swiftUIColor
        static let assistive = DesignSystemAsset.neutral10.swiftUIColor
    }
    
    public struct Background {
        static let primary = DesignSystemAsset.neutral90.swiftUIColor
        static let assistive = DesignSystemAsset.neutral10.swiftUIColor
        static let dimmer = Color.Text.primary.opacity(40)
        static let brand = DesignSystemAsset.orange100.swiftUIColor
        static let brandassistive = DesignSystemAsset.orange10.swiftUIColor
        static let white = DesignSystemAsset.common100.swiftUIColor
    }
    
    public struct Skeleton {
        static let primary = DesignSystemAsset.neutral10.swiftUIColor
        static let secondary = DesignSystemAsset.neutral20.swiftUIColor
    }

}
