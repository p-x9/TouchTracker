# TouchTracker

Show a mark at the touched point on the View of SwiftUI.

## Demo

https://user-images.githubusercontent.com/50244599/231504004-e1a1e815-3156-4f03-ba52-316afa061781.MP4

## Document
Set the following for a View of SwiftUI.
```swift
Text("Hello")
    .touchTrack()
```
Alternatively, it can also be written as follows
```swift
TouchTrackingView {
    Text("Hello")
}
```

### Customize
```swift
Text("Hello")
    .touchTrack() // show touch point
    .touchPointRadius(8) // radius of mark on touched point
    .touchPointOffset(x: 0, y: -10) // offset of mark position
    .touchPointColor(.orange) // color of mark on touched point
    .touchPointBorder(true, color: .blue, width: 1) // applying a border to touched points
    .touchPointShadow(true, color: .purple, radius: 3) // shadow on touched points
    .touchPointDisplayMode(.recordingOnly) // display mode of touched points
    .showLocationLabel(true) // show touch coordinate
```
![Example](https://user-images.githubusercontent.com/50244599/231509731-d3ea5df0-1981-4911-9a14-2b57bf575eb7.PNG)

It is also possible to display images as follow
```swift
Text("Hello")
    .touchPointImage(Image(systemName: "swift").resizable())
```
![Example2](https://user-images.githubusercontent.com/50244599/231510854-c1669ba5-2071-446d-8cda-5131bce14511.PNG)

### UIKit
If you want to adapt it to the entire app created with UIKit, write the following.
Use a view named `TouchTrackingUIView`
```swift
import TouchTracker

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let v = TouchTrackingUIView(isShowLocation: true)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if let window {
            window.addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                v.topAnchor.constraint(equalTo: window.topAnchor),
                v.bottomAnchor.constraint(equalTo: window.bottomAnchor),
                v.leftAnchor.constraint(equalTo: window.leftAnchor),
                v.rightAnchor.constraint(equalTo: window.rightAnchor),
            ])
        }
        return true
    }
```


#### Propagate touch events to other windows
The following configuration allows you to share a touch event received in one window with other windows.

```swift
v.shouldPropagateEventAcrossWindows = true
```

In the given configuration, even when windows overlap, typically only one window receives a touch event.
Moreover, if a touch event starts in one window, such as Window A, it will only be responsive in Window A, even if it moves to another window, like Window B.

Therefore, the touch event can be shared so that the marker of the tapped point will be displayed in the other window even in such a case.


## License
TouchTracker is released under the MIT License. See [LICENSE](./LICENSE)
