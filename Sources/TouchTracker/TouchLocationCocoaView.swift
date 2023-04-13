//
//  TouchLocationCocoaView.swift
//  
//
//  Created by p-x9 on 2023/04/12.
//  
//

#if canImport(UIKit)
import UIKit

class TouchLocationCocoaView: UIView {
    var touchesChangeHandler: (([CGPoint]) -> Void)?

    var touches: Set<UITouch> = []
    var locations: [CGPoint] = [] {
        didSet {
            touchesChangeHandler?(locations)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touches.formUnion(touches)
        self.locations = self.touches.map { $0.location(in: self) }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.locations = self.touches.map { $0.location(in: self) }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touches.subtract(touches)
        self.locations = self.touches.map { $0.location(in: self) }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touches.subtract(touches)
        self.locations = self.touches.map { $0.location(in: self) }
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        false
    }
}
#endif
