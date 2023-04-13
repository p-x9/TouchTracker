//
//  UIWindow+.swift
//  
//
//  Created by p-x9 on 2023/04/13.
//  
//

#if canImport(UIKit)
import UIKit

extension UIView {
    func find<T>(for type: T.Type) -> [T] {
        var result = [T]()
        for subview in subviews {
            if let typed = subview as? T {
                result.append(typed)
            } else {
                result += subview.find(for: type)
            }
        }
        return result
    }
}

extension UIWindow {
    static public var hooked = false

    static func hook() {
        if Self.hooked { return }
        Self.swizzle(orig: #selector(sendEvent(_:)), hooked: #selector(hooked_sendEvent(_:)))
    }

    @objc
    func hooked_sendEvent(_ event: UIEvent) {
        hooked_sendEvent(event)

        guard let touches = event.allTouches else { return }

        let began = touches.filter { $0.phase == .began }
        let moved = touches.filter { $0.phase == .moved }
        let ended = touches.filter { $0.phase == .cancelled || $0.phase == .ended }

        let touchLocationViews = find(for: TouchLocationUIView.self)

        touchLocationViews
            .filter {
                if let superview = $0.superview {
                    return !superview.isHidden
                }
                return true
            }
            .forEach { view in
                if !began.isEmpty {
                    view.touchesBegan(began, with: event)
                }
                if !moved.isEmpty {
                    view.touchesMoved(moved, with: event)
                }
                if !ended.isEmpty {
                    view.touchesEnded(ended, with: event)
                }
            }
    }
}

#endif
