//
//  NSObject+.swift
//  
//
//  Created by p-x9 on 2023/04/13.
//  
//

import Foundation
import ObjectiveC

extension NSObject {

    @discardableResult
    static func swizzle(orig origSelector: Selector, hooked hookedSelector: Selector) -> Bool {
        guard let origMethod = class_getInstanceMethod(Self.self, origSelector),
              let hookedMethod = class_getInstanceMethod(Self.self, hookedSelector) else {
            return false
        }

        let didAddMethod = class_addMethod(Self.self, origSelector,
                                           method_getImplementation(hookedMethod),
                                           method_getTypeEncoding(hookedMethod))
        if didAddMethod {
            class_replaceMethod(Self.self, hookedSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod))
            return true
        }
        method_exchangeImplementations(origMethod, hookedMethod)
        return true
    }
}
