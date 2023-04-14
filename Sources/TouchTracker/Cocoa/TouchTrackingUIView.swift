//
//  CocoaTrackPointManager.swift
//  
//
//  Created by p-x9 on 2023/04/14.
//  
//

#if canImport(UIKit)
import UIKit

public class TouchTrackingUIView: UIView {
    let radius: CGFloat

    var color: UIColor

    var offset: CGPoint

    var isBordered: Bool
    var borderColor: UIColor
    var borderWidth: CGFloat

    var isDropShadow: Bool
    var shadowColor: UIColor
    var shadowRadius: CGFloat

    var image: UIImage?

    var isShowLocation: Bool


    var touches: Set<UITouch> = []
    var locations: [CGPoint] = [] {
        didSet {
            updatePoints()
        }
    }

    var pointViews = [TouchPointUIView]()

    public init(
        radius: CGFloat = 20,
        color: UIColor = .red,
        offset: CGPoint = .zero,
        isBordered: Bool = false,
        borderColor: UIColor = .black,
        borderWidth: CGFloat = 1,
        isDropShadow: Bool = true,
        shadowColor: UIColor = .black,
        shadowRadius: CGFloat = 3,
        image: UIImage? = nil,
        isShowLocation: Bool = false
    ) {
        self.radius = radius
        self.color = color
        self.offset = offset
        self.isBordered = isBordered
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.isDropShadow = isDropShadow
        self.shadowColor = shadowColor
        self.shadowRadius = shadowRadius
        self.image = image
        self.isShowLocation = isShowLocation

        super.init(frame: .null)

        isUserInteractionEnabled = false

        UIWindow.hook()
    }

    @available(iOS 14.0, *)
    public convenience init(style: TouchPointStyle) {
        self.init(
            radius: style.radius,
            color: UIColor(style.color),
            offset: style.offset,
            isBordered: style.isBordered,
            borderColor: UIColor(style.borderColor),
            borderWidth: style.borderWidth,
            isDropShadow: style.isDropShadow,
            shadowColor: UIColor(style.shadowColor),
            shadowRadius: style.shadowRadius,
            isShowLocation: style.isShowLocation
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touches.formUnion(touches)
        self.locations = self.touches.map { $0.location(in: self) }
    }

    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.locations = self.touches.map { $0.location(in: self) }
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touches.subtract(touches)
        self.locations = self.touches.map { $0.location(in: self) }
    }

    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touches.subtract(touches)
        self.locations = self.touches.map { $0.location(in: self) }
    }

    func updatePoints() {
        if pointViews.count > touches.count {
            pointViews[touches.count..<pointViews.count].forEach {
                $0.isHidden = true
                $0.windowScene = nil
            }
            pointViews = Array(pointViews[0..<touches.count])
        }
        if pointViews.count < touches.count {
            let diff = touches.count - pointViews.count
            pointViews += (0..<diff).map { _ in
                TouchPointUIView(
                    location: .zero,
                    radius: radius,
                    color: color,
                    isBordered: isBordered,
                    borderColor: borderColor,
                    borderWidth: borderWidth,
                    isDropShadow: isDropShadow,
                    shadowColor: shadowColor,
                    shadowRadius: shadowRadius,
                    isShowLocation: isShowLocation
                )
            }
        }

        zip(pointViews, locations).forEach { view, location in
            view.location = location
            view.center = .init(x: location.x + offset.x,
                                y: location.y + offset.y)
            view.makeKeyAndVisible()
        }
    }
}

#endif
