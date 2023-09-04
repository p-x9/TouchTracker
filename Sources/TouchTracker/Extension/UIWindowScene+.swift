//
//  UIWindowScene+.swift
//  
//
//  Created by p-x9 on 2023/09/05.
//  
//

#if canImport(UIKit)
import UIKit

extension UIWindowScene {
    static func keyboardScene(for screen: UIScreen) -> UIWindowScene? {
        // _keyboardWindowSceneForScreen:create:
        let obfuString = [":etaer", "c:nee", "rcSroF", "e", "necSwod", "niWdraobyek_"]
        let name = String(obfuString.joined(separator: "").reversed())

        let selector = Selector(name)
        guard UIWindowScene.responds(to: selector),
              let scene = UIWindowScene.perform(selector, with: screen, with: false).takeUnretainedValue() as? UIWindowScene else {
            return nil
        }

        return scene
    }

    var allWindows: [UIWindow] {
        // _allWindows
        let name = String(["_", "al", "lWin", "dows"].joined(separator: ""))
        let selector = Selector(name)
        guard self.responds(to: selector),
              let windows = self.perform(selector).takeUnretainedValue() as? [UIWindow] else {
            return []
        }

        return windows
    }
}

#endif
