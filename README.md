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
    .touchPointColor(.orange) // color of mark on touched point
    .touchPointBorder(true, color: .blue, width: 1) // applying a border to touched points
    .touchPointShadow(true, color: .purple, radius: 3) // shadow on touched points
    .showLocationLabel(true) // show touch coordinate
```
![Example](https://user-images.githubusercontent.com/50244599/231509731-d3ea5df0-1981-4911-9a14-2b57bf575eb7.PNG)

It is also possible to display images as follow
```swift
Text("Hello")
    .touchPointImage(Image(systemName: "swift").resizable())
```
![Example2](https://user-images.githubusercontent.com/50244599/231510854-c1669ba5-2071-446d-8cda-5131bce14511.PNG)
