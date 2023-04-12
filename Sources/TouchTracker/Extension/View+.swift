//
//  View+.swift
//  
//
//  Created by p-x9 on 2023/04/12.
//  
//

import SwiftUI

// ref: https://github.com/YusukeHosonuma/SwiftUI-Common/blob/main/Sources/SwiftUICommon/Extension/View%2B.swift
extension View {
    @ViewBuilder
    func when<Content: View>(_ condition: Bool, @ViewBuilder transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }

    @ViewBuilder
    func whenLet<V, Content: View>(_ optional: V?, @ViewBuilder transform: (Self, V) -> Content) -> some View {
        if let value = optional {
            transform(self, value)
        } else {
            self
        }
    }
}

