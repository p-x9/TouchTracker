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

        let touchLocationViews = find(for: TouchLocationUIView.self)

        touchLocationViews
            .filter {
                if let superview = $0.superview {
                    return !superview.isHidden
                }
                return true
            }
            .forEach { view in
                let touches = event.allTouches
                touches?.forEach { touch in
                    switch touch.phase {
                    case .began:
                        view.touchesBegan(Set([touch]), with: event)
                    case .moved:
                        view.touchesMoved(Set([touch]), with: event)
                    case .ended:
                        view.touchesEnded(Set([touch]), with: event)
                    case .cancelled:
                        view.touchesCancelled(Set([touch]), with: event)
                    default:
                        break
                    }
                }
            }
    }
}

#endif
