//
//  TouchPointUIView.swift
//  
//
//  Created by p-x9 on 2023/04/14.
//  
//

#if canImport(UIKit)
import UIKit

class TouchPointUIView: UIWindow {
    var location: CGPoint {
        didSet {
            let x = String(format: "%.1f", location.x)
            let y = String(format: "%.1f", location.y)
            locationLabel.text = "x: \(x)\ny: \(y)"
        }
    }
    var radius: CGFloat

    var color: UIColor

    var isBordered: Bool
    var borderColor: UIColor
    var borderWidth: CGFloat

    var isDropShadow: Bool
    var shadowColor: UIColor
    var shadowRadius: CGFloat
    var shadowOffset: CGPoint

    var image: UIImage?

    var isShowLocation: Bool

    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    init(
        location: CGPoint,
        radius: CGFloat,
        color: UIColor,
        isBordered: Bool,
        borderColor: UIColor,
        borderWidth: CGFloat,
        isDropShadow: Bool,
        shadowColor: UIColor,
        shadowRadius: CGFloat,
        shadowOffset: CGPoint,
        image: UIImage? = nil,
        isShowLocation: Bool
    ) {
        self.location = location
        self.radius = radius
        self.color = color
        self.isBordered = isBordered
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.isDropShadow = isDropShadow
        self.shadowColor = shadowColor
        self.shadowRadius = shadowRadius
        self.shadowOffset = shadowOffset
        self.image = image
        self.isShowLocation = isShowLocation

        let frame = CGRect(origin: .zero,
                           size: .init(width: radius * 2, height: radius * 2))
        super.init(frame: frame)

        setupViews()
        setupViewConstraints()

        windowLevel = .init(10000005)
        isUserInteractionEnabled = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        layer.cornerRadius = radius
        backgroundColor = color

        if isBordered {
            layer.borderWidth = borderWidth
            layer.borderColor = borderColor.cgColor
        }

        if isDropShadow {
            // shadowOpacity is configured by alpha of shadowColor directly
            layer.shadowOpacity = 1
            layer.shadowOffset = .init(width: shadowOffset.x, height: shadowOffset.y)
            layer.shadowColor = shadowColor.cgColor
            layer.shadowRadius = shadowRadius
        }

        if let image {
            imageView.image = image
            addSubview(imageView)
        }

        if isShowLocation {
            addSubview(locationLabel)
        }
    }

    func setupViewConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: radius * 2),
            self.widthAnchor.constraint(equalToConstant: radius * 2),
        ])

        if let _ = image {
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: topAnchor),
                imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
                imageView.leftAnchor.constraint(equalTo: leftAnchor),
                imageView.rightAnchor.constraint(equalTo: rightAnchor),
            ])
        }

        if isShowLocation {
            NSLayoutConstraint.activate([
                locationLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                locationLabel.bottomAnchor.constraint(equalTo: topAnchor, constant: -shadowRadius)
            ])
        }
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        false
    }
}
#endif

