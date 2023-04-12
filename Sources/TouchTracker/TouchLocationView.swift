//
//  TouchLocationView.swift
//  
//
//  Created by p-x9 on 2023/04/12.
//  
//

import SwiftUI

#if canImport(UIKit)
import UIKit

struct TouchLocationView: UIViewRepresentable {
    @Binding var locations: [CGPoint]

    init(_ locations: Binding<[CGPoint]>) {
        self._locations = locations
    }

    func makeUIView(context: Context) -> some UIView {
        let view = TouchLocationUIView()
        view.touchesChangeHandler = { locations in
            self.$locations.wrappedValue = locations
        }
        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let view = uiView as? TouchLocationUIView else { return }
        view.touchesChangeHandler = { locations in
            self.$locations.wrappedValue = locations
        }
    }
}

#endif
