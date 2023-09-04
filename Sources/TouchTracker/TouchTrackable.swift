//
//  TouchTrackable.swift
//  
//
//  Created by p-x9 on 2023/09/03.
//  
//

#if canImport(UIKit)
import UIKit

protocol TouchTrackable: UIView {
    func touchesBegan(_ touches: Set<UITouch>, with receiver: UIWindow)
    func touchesMoved(_ touches: Set<UITouch>, with receiver: UIWindow)
    func touchesEndedOrCancelled(_ touches: Set<UITouch>, with receiver: UIWindow)
}

#endif
