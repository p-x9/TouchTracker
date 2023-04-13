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

struct TouchLocationView<Content: View>: UIViewControllerRepresentable {
    @Binding var locations: [CGPoint]
    let content: () -> Content

    init(_ locations: Binding<[CGPoint]>, content: @escaping () -> Content) {
        self._locations = locations
        self.content = content
    }

    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = TouchLocationWrapView(rootView: content())
        controller.touchesChangeHandler = { locations in
            self.$locations.wrappedValue = locations
        }
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        guard let controller = uiViewController as? TouchLocationWrapView<Content> else { return }
        controller.rootView = content()
        controller.touchesChangeHandler = { locations in
            self.$locations.wrappedValue = locations
        }
    }
    
}

class TouchLocationWrapView<Content: View>: UIHostingController<Content> {
    var touchesChangeHandler: (([CGPoint]) -> Void)?

    var touches: Set<UITouch> = []
    var locations: [CGPoint] = [] {
        didSet {
            touchesChangeHandler?(locations)
        }
    }

    lazy var trackLocationUIView: TouchLocationUIView  = {
        let view = TouchLocationUIView(frame: .null)
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.touchesChangeHandler = { [weak self] locations in
            self?.touchesChangeHandler?(locations)
        }
        return view
    }()

    override init(rootView: Content) {
        super.init(rootView: rootView)

        setupTouchLocationView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupTouchLocationView() {
        view.addSubview(trackLocationUIView)

        NSLayoutConstraint.activate([
            trackLocationUIView.topAnchor.constraint(equalTo: view.topAnchor),
            trackLocationUIView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            trackLocationUIView.leftAnchor.constraint(equalTo: view.leftAnchor),
            trackLocationUIView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
}

#endif
