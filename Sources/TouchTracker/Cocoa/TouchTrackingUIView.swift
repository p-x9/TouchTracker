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
    /// radius of mark on touched point
    public var radius: CGFloat
    /// color of mark on touched point
    public var color: UIColor

    /// offset of mark on touched point/
    public var offset: CGPoint

    /// A boolean value that indicates whatever adding a border to the mark of the touched point, or
    public var isBordered: Bool
    /// border color of mark on touched point
    public var borderColor: UIColor
    /// border width of mark on touched point
    public var borderWidth: CGFloat

    /// A boolean value that indicates whatever adding shadow to the mark of the touched point
    public var isDropShadow: Bool
    /// shadow color of mark on touched point
    public var shadowColor: UIColor
    /// shadow radius of mark on touched point
    public var shadowRadius: CGFloat
    /// shadow offset of mark on touched point
    public var shadowOffset: CGPoint

    /// Image to be displayed at the touched point mark
    public var image: UIImage?

    /// A boolean value that indicates whatever adding show coordinates label or not
    public var isShowLocation: Bool

    /// display mode of touched points.
    public var displayMode: DisplayMode

    /// A boolean value that indicates whether the event should propagate across windows.
    /// If set to `true`, the touch events received in one window will also be shared
    /// with other windows when applicable.
    public var shouldPropagateEventAcrossWindows: Bool = false

    var touches: Set<UITouch> = []
    var locations: [CGPoint] = [] {
        didSet {
            DispatchQueue.main.async {
                self.updatePoints()
            }
        }
    }

    /// If set to false, the touched point will not be displayed
    public var isEnabled: Bool = true

    var pointWindows = [TouchPointUIView]()

    /// initializer
    /// - Parameters:
    ///   - radius: radius of mark on touched point
    ///   - color: color of mark on touched point
    ///   - offset: offset of mark on touched point/
    ///   - isBordered: A boolean value that indicates whatever adding a border to the mark of the touched point, or
    ///   - borderColor: border color of mark on touched point
    ///   - borderWidth: border width of mark on touched point
    ///   - isDropShadow: A boolean value that indicates whatever adding shadow to the mark of the touched point
    ///   - shadowColor: shadow color of mark on touched point
    ///   - shadowRadius: shadow radius of mark on touched point
    ///   - shadowOffset: shadow offset of mark on touched point
    ///   - image: Image to be displayed at the touched point mark
    ///   - isShowLocation: A boolean value that indicates whatever adding show coordinates label or not
    ///   - displayMode: display mode of touched points.
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
        shadowOffset: CGPoint = .zero,
        image: UIImage? = nil,
        isShowLocation: Bool = false,
        displayMode: DisplayMode = .always
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
        self.shadowOffset = shadowOffset
        self.image = image
        self.isShowLocation = isShowLocation
        self.displayMode = displayMode

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
            shadowOffset: style.shadowOffset,
            isShowLocation: style.isShowLocation
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        pointWindows.forEach {
            $0.isHidden = true
        }
    }

    func updateLocations() {
        if !isEnabled {
            self.touches = []
        }

        self.touches = self.touches.filter { $0.phase != .cancelled && $0.phase != .ended }
        let newLocations = self.touches.map { $0.location(in: self) }
        if self.locations != newLocations {
            self.locations = newLocations
        }
    }

    func updatePoints() {
        let isCaptured = window?.screen.isCaptured ?? false
        let shouldDisplay = displayMode.shouldDisplay(captured: isCaptured)

        if !shouldDisplay {
            pointWindows.forEach { $0.isHidden = true }
            pointWindows = []
            return
        }

        if pointWindows.count > touches.count {
            pointWindows[touches.count..<pointWindows.count].forEach {
                $0.isHidden = true
                $0.windowScene = nil
                if $0.superview != nil {
                    $0.uiviewRemoveFromSuperView()
                }
            }
            pointWindows = Array(pointWindows[0..<touches.count])
        }
        if pointWindows.count < touches.count {
            let diff = touches.count - pointWindows.count
            pointWindows += (0..<diff).map { _ in
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
                    shadowOffset: shadowOffset,
                    image: image,
                    isShowLocation: isShowLocation
                )
            }
        }

        let globalLocations = touches.map { $0.location(in: nil) }

        zip(pointWindows, zip(locations, globalLocations)).forEach { window, location in
            let (location, globalLocation) = location

            window.location = location
            window.center = .init(x: globalLocation.x + offset.x,
                                  y: globalLocation.y + offset.y)

            if shouldPropagateEventAcrossWindows,
               let screen = self.window?.screen,
               let keyboardScene = UIWindowScene.keyboardScene(for: screen),
               let keyboardRemoteWindow = keyboardScene.allWindows.first {
                window.rootViewController = nil
                keyboardRemoteWindow.addSubview(window)
            } else {
                // WORKAROUND: Apply changes of orientation
                if window.rootViewController == nil {
                    window.rootViewController = .init()
                }
                window.windowScene = self.window?.windowScene
            }

            window.isHidden = false
        }
    }
}

extension TouchTrackingUIView: TouchTrackable {
    func touchesBegan(_ touches: Set<UITouch>, with receiver: UIWindow) {
        if !shouldPropagateEventAcrossWindows && window != receiver {
            return
        }
        self.touches.formUnion(touches)
        updateLocations()
    }

    func touchesMoved(_ touches: Set<UITouch>, with receiver: UIWindow) {
        if !shouldPropagateEventAcrossWindows && window != receiver {
            return
        }
        updateLocations()
    }

    func touchesEndedOrCancelled(_ touches: Set<UITouch>, with receiver: UIWindow) {
        if !shouldPropagateEventAcrossWindows && window != receiver {
            return
        }
        self.touches.subtract(touches)
        updateLocations()
    }
}

#endif
