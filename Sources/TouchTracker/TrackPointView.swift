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

    var color: Color = .red

    var isBordered: Bool = true
    var borderColor: Color = .black
    var borderWidth: CGFloat = 1

    var isDropShadow: Bool = true
    var shadowColor: Color = .black
    var shadowRadius: CGFloat = 3

    var image: Image?

    var isShowLocation: Bool = false

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
                    locationText
                        .position(x: radius, y: -16 - shadowRadius)
                )
            }
    }
}
