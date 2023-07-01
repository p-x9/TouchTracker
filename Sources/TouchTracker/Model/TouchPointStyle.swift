//
//  TouchPointStyle.swift
//  
//
//  Created by p-x9 on 2023/04/14.
//  
//

import SwiftUI

public struct TouchPointStyle: Equatable {
    /// radius of mark on touched point
    public var radius: CGFloat
    /// color of mark on touched point
    public var color: Color

    /// offset of mark on touched point
    public var offset: CGPoint = .zero

    /// A boolean value that indicates whatever adding a border to the mark of the touched point, or
    public var isBordered: Bool
    /// border color of mark on touched point
    public var borderColor: Color
    /// border width of mark on touched point
    public var borderWidth: CGFloat

    /// A boolean value that indicates whatever adding shadow to the mark of the touched point
    public var isDropShadow: Bool
    /// shadow color of mark on touched point
    public var shadowColor: Color
    /// shadow radius of mark on touched point
    public var shadowRadius: CGFloat
    /// shadow offset of mark on touched point
    public var shadowOffset: CGPoint

    /// A boolean value that indicates whatever adding show coordinates label or not
    public var isShowLocation: Bool
    
    /// Initializer
    /// - Parameters:
    ///   - radius: radius of mark on touched point
    ///   - color: color of mark on touched point
    ///   - offset: offset of mark on touched point/
    ///   - isBordered: A boolean value that indicates whatever adding a border to the mark of the touched point, or
    ///   - borderColor: border color of mark on touched point
    ///   - borderWidth: border width of mark on touched point
    ///   - isDropShadow: A boolean value that indicates whatever adding shadow to the mark of the touched point
    ///   - shadowColor: shadow color of mark on touched point
    ///   - shadowRadius: shadow radius of mark on touched point
    ///   - shadowOffset: shadow offset of mark on touched point
    ///   - isShowLocation: A boolean value that indicates whatever adding show coordinates label or not
    public init(
        radius: CGFloat = 20,
        color: Color = .red,
        offset: CGPoint = .zero,
        isBordered: Bool = false,
        borderColor: Color = .black,
        borderWidth: CGFloat = 1,
        isDropShadow: Bool = true,
        shadowColor: Color = .black,
        shadowRadius: CGFloat = 3,
        shadowOffset: CGPoint = .zero,
        isShowLocation: Bool = false
    ) {
        self.radius = radius
        self.color = color
        self.offset = offset
        self.isBordered = isBordered
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.isDropShadow = isDropShadow
        self.shadowColor = shadowColor
        self.shadowRadius = shadowRadius
        self.shadowOffset = shadowOffset
        self.isShowLocation = isShowLocation
    }
}
