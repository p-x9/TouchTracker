//
//  TrackPointView.swift
//  
//
//  Created by p-x9 on 2023/04/12.
//  
//

import SwiftUI

struct TouchPointView: View {
    let location: CGPoint
    let radius: CGFloat

    var color: Color

    var isBordered: Bool
    var borderColor: Color
    var borderWidth: CGFloat

    var isDropShadow: Bool
    var shadowColor: Color
    var shadowRadius: CGFloat

    var image: Image?

    var isShowLocation: Bool

    var locationText: some View {
        let x = String(format: "%.1f", location.x)
        let y = String(format: "%.1f", location.y)

        return Text("x: \(x)\ny: \(y)")
            .font(.system(size: 10))
            .lineLimit(2)
            .frame(maxWidth: .infinity)
    }

    var body: some View {
        color
            .frame(width: radius * 2, height: radius * 2)
            .cornerRadius(radius)
            .when(isBordered) {
                $0.overlay(
                    RoundedRectangle(cornerRadius: radius)
                        .stroke(borderColor, lineWidth: borderWidth)
                )
            }
            .whenLet(image) {
                $0.overlay($1)
            }
            .when(isDropShadow) {
                $0.shadow(color: shadowColor, radius: shadowRadius)
            }
            .when(isShowLocation) {
                $0.overlay(
                    HStack(alignment: .center) {
                        locationText
                            .fixedSize()
                    }
                        .position(x: radius, y: -16 - shadowRadius)
                )
            }
    }
}
