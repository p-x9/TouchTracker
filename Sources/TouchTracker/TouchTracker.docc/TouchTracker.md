# ``TouchTracker``

👆Show a mark at the touched point on the View.

@Metadata {
    @DocumentationExtension(mergeBehavior: append)
    @Available(iOS, introduced: "13.0")
}

<!--@START_MENU_TOKEN@-->Summary<!--@END_MENU_TOKEN@-->

## Overview

``TouchTracker`` allows you to display a mark on a touched point on your app with a simple setup.
Both UIKit and SwiftUI are supported.

![Example of TouchTracker](TouchTrackerExample.png)

In SwiftUI, it can be used as follows

```swift
Text("Hello")
    .touchTrack()
```

In the case of UIKit, this can be set by adding ``TouchTrackingUIView`` to the subview as follows.

```swift
let v = TouchTrackingUIView()

self.view.addSubview(v)

v.translatesAutoresizingMaskIntoConstraints = false
NSLayoutConstraint.activate([
    v.topAnchor.constraint(equalTo: window.topAnchor),
    v.bottomAnchor.constraint(equalTo: window.bottomAnchor),
    v.leftAnchor.constraint(equalTo: window.leftAnchor),
    v.rightAnchor.constraint(equalTo: window.rightAnchor),
])
```

<!--@START_MENU_TOKEN@-->Text<!--@END_MENU_TOKEN@-->

## Topics

### <!--@START_MENU_TOKEN@-->Group<!--@END_MENU_TOKEN@-->

- <!--@START_MENU_TOKEN@-->``Symbol``<!--@END_MENU_TOKEN@-->
