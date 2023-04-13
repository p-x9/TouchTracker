//
//  TouchPointStyle.swift
//  
//
//  Created by p-x9 on 2023/04/14.
//  
//

import SwiftUI

public struct TouchPointStyle: Equatable {
    public var radius: CGFloat
    public var color: Color

    public var isBordered: Bool
    public var borderColor: Color
    public var borderWidth: CGFloat

    public var isDropShadow: Bool
    public var shadowColor: Color
    public var shadowRadius: CGFloat

    public var isShowLocation: Bool

    public init(
        radius: CGFloat = 20,
        color: Color = .red,
        isBordered: Bool = false,
        borderColor: Color = .black,
        borderWidth: CGFloat = 1,
        isDropShadow: Bool = true,
        shadowColor: Color = .black,
        shadowRadius: CGFloat = 3,
        isShowLocation: Bool = false
    ) {
        self.radius = radius
        self.color = color
        self.isBordered = isBordered
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.isDropShadow = isDropShadow
        self.shadowColor = shadowColor
        self.shadowRadius = shadowRadius
        self.isShowLocation = isShowLocation
    }
}
