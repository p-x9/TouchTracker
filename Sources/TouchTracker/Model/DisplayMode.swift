//
//  DisplayMode.swift
//  
//
//  Created by p-x9 on 2023/08/23.
//  
//

#if canImport(UIKit)
import UIKit
#endif

public enum DisplayMode {
    case always
    case debugOnly
    case recordingOnly
}

#if canImport(UIKit)
extension DisplayMode {
    func shouldDisplay(captured: Bool) -> Bool {
        switch self {
        case .always:
            return true
        case .debugOnly:
#if DEBUG
            return true
#else
            return false
#endif
        case .recordingOnly:
            return captured
        }
    }
}
#endif
