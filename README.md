![](./Images/logo_Extra.png)

# Extra 👌🏼

[![CI Status](http://img.shields.io/travis/smartnsoft/Extra.svg?style=flat)](https://travis-ci.org/smartnsoft/Extra)
[![Version](https://img.shields.io/cocoapods/v/Extra.svg?style=flat)](http://cocoapods.org/pods/Extra)
[![License](https://img.shields.io/cocoapods/l/Extra.svg?style=flat)](http://cocoapods.org/pods/Extra)
[![Platform](https://img.shields.io/cocoapods/p/Extra.svg?style=flat)](http://cocoapods.org/pods/Extra)

A Swift 4 library with usefull and lightfull extensions for your Cocoa Touch projects.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 9+
- Xcode 9+, Swift 4

## Installation

Extra is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Extra"

# or via subspec :

pod "Extra/UIKit"
pod "Extra/Foundation"
pod "Extra/Realm"
```

## Content

UI | Utils | Third-party libraries
------------ | ------------- | -------------
[UIApplication](#uiAppAnchor) | [String](#stringAnchor) | [Realm](#realmAnchor)
[UICollectionView](#uiCollectionViewAnchor) | [Collection](#collectionAnchor)
[UITableView](#uiTableViewAnchor) | [Sequence](#sequenceAnchor)
[UIView](#uiViewAnchor) |
[UIImage](#uiImageAnchor) |
[UIButton](#uiButtonAnchor) |
[UILabel](#uiLabelAnchor) |
[UITextView](#uiTextViewAnchor) |
[UIColor](#uiColorAnchor) |
[UIDevice](#uiDeviceAnchor) |
[UIViewController](#uiVcAnchor) |
[UINavigationController](#uiNavControllerAnchor) |

## Usage

**Use the `ex` variable on your current type to access to the Extra methods :**

`UIApplication.ex.hideActivityIndicator()`

## UIKit extensions 🎨

### <a id="uiAppAnchor">`UIApplication`</a>
-  `UIActivityIndicator` accessibility : `hideActivityIndicator()` / `showActivityIndicator()`
-  `isLandscape()` / `isPortrait()` quick access

### <a id="uiCollectionViewAnchor">`UICollectionView`</a>
##### `UICollectionView`

-  `currentIndexPathForCenter()` : return the index path of cell displayed at the center(x,y) of the UICollectionView
-  `public func scrollVertically(to: IndexPath, accordingTo: IndexPath, animated: Bool = default)` : scroll to an item an be sur to let the other be vivisble if possible

##### `UICollectionViewCell`

-  `collectionView` property : return the current UICollectionView related to the cell

###  <a id="uiTableViewAnchor">`UITableView`</a>
####  `UITableView`

-  `setAndLayoutTableHeaderView(_ headerView: UIView, edges: UIEdgeInsets? = default)` : Configure and set the global table HeaderView and correctly set the frame to the fitting size
-  `layoutTableHeaderView(_ headerView: UIView, edges: UIEdgeInsets? = default)` : Automatic height for your header. Call it on didLayoutSubviews
-  `setAndLayoutTableFooterView(_ footerView: UIView, edges: UIEdgeInsets? = default)` : Configure and set the global table FooterView and correctly set the frame to the fitting size
-  `layoutTableFooterView(_ footerView: UIView, edges: UIEdgeInsets? = default)` : Automatic height for your footer. Call it on didLayoutSubviews
-  `scrollToTop(animated: Bool)` : Scrolls the tableView to the top (including its headerView).

####  `UITableViewCell`

-  `tableView` property : return the current UICollectionView related to the cell

###  <a id="uiColorAnchor">`UIColor`</a>

-  `toImage(size: CGSize = default) -> UIImage?` : Transform the current color to a sizable UIImage
-  `fromHexa(_ hexaString: String, alpha: CGFloat = default) -> UIColor?` : Create a color from an hexa string

###  <a id="uiDeviceAnchor">`UIDevice`</a>

-  `isPad` / `isPhone` quick access

###  <a id="uiImageAnchor">`UIImage`</a>

-  `from(color: UIColor, size: CGSize, cornerRadius: CGFloat = default) -> UIImage?` : Creates an UIImage from and UIColor This is usefull for your UIButton to set filled background color for states.
-  `toBlackAndWhite() -> UIImage?` : Transforms the current image to a new one with the `CIColorMonochrome` filter, with black input color.
-  `imageRotatedByDegrees(degrees: CGFloat) -> UIImage?` : Correctly rotate your image according to the desired degrees.
-  `scaledFilledToSize(size: CGSize) -> UIImage?` : This will resize the UIImage to the destination size This will fill your UIImage (and potentially enlarge it) By this way, this will not produce empty space on top/bottom or left/right sides, the ratio will not change.
-  `resizableImageByCenter() -> UIImage` : Simple resize of your image based to it center.
-  `cutTile(with rect: CGRect) -> UIImage?` : Cut and return a tile in the image with specified rect.
-  `scaledAspectFill(to size: CGSize) -> UIImage?` : Creates a copy of the image simulating aspect fill to specified size

###  <a id="uiButtonAnchor">`UIButton`</a>

-  `configureTitle(with title: String, font: UIFont, color: UIColor, highlightedColor: UIColor? = nil)` : Configures the title of the button in normal and highlighted states
-  `configureLeftIcon(with image: UIImage, insets: UIEdgeInsets = .zero)` : Configures left icon of the button
-  `configureBackground(with color: UIColor, highlightedColor: UIColor? = nil)` : Configures background of the button in normal and highlighted states

###  <a id="uiLabelAnchor">`UILabel`</a>

- `width(fitting containerHeight: CGFloat, string: String, attributes: [NSAttributedStringKey: Any]) -> CGFloat` : Estimates width of a label required to display specified text fitting container height.
- `width(fitting containerHeight: CGFloat, attributedString: NSAttributedString) -> CGFloat` : Estimates width of a label required to display specified text fitting container height.
- `height(fitting containerWidth: CGFloat, string: String, attributes: [NSAttributedStringKey: Any]) -> CGFloat` : Estimates height of a label required to display specified text fitting container width.
- `height(fitting containerWidth: CGFloat, attributedString: NSAttributedString) -> CGFloat` : Estimates height of a label required to display specified text fitting container width.

###  <a id="uiTextViewAnchor">`UITextView`</a>

- `setNoPadding()` : Configures textView without padding.

####  <a id="uiNavControllerAnchor">`UINavigationController`</a>

-  `popPreviousAndPushViewController(_ controller: UIViewController)` : The effect is like a replacement of the current stack, but just the last one UIViewController.
-  `popViewControllers(numberOf: Int, animated: Bool = default)` : Pop the current stack of Navigation Controller by the specified number.

###  <a id="uiViewAnchor">`UIView`</a>

-  `initXib()` : Use this method in your custom UIView with a specified Xib, to add your xib content at creation
-  `instantiateFromNib() -> UIView` : Create and retrieve the root UIView of your Xib based on the current UIView class name
-  `addSubview(_ subview: UIView, insets: UIEdgeInsets)` : Add a subview into the current UIView with potential insets.
-  `removeAllSubViews()` : Recursively remove all your related subviews
-  `setAllSubviewsHidden(_ hidden: Bool)` : Recursively hide all your related subviews
-  `addClearToDarkGradient(radius: CGFloat = default, direction: ExtraGradientDirection)` : This will create a gradient into your current UIView (so this is available for UIImageView) Be sure to have a background color dark to have good results
-  `roundCorners(_ corners: UIRectCorner, radius: CGSize)` : Apply a rounded mask to the current view
-  `addDashedBorder(color: CGColor, thickness: CGFloat)` : Apply a dashed border to the current view
- `addShadowBorder(color: UIColor, size: CGFloat)` : Apply a shadow to all edges except the top border.
- `addBottomDivider(color: UIColor, alpha: CGFloat, widthMultiplier: CGFloat)` : Apply a bottom divider to the current view

###  <a id="uiVcAnchor">`UIViewController`</a>

-  `topMost() -> UIViewController?` : Returns the current application’s top most view controller.
-  `addChildViewController(_ childController: UIViewController, in container: UIView, insets: UIEdgeInsets = default)` : Simply programmatically adding a child view controller
-  `switchChilds(from originController: UIViewController?, to destinationController: UIViewController, in viewContainer: UIView, duration: TimeInterval = default, transitionOptions: UIViewAnimationOptions = default, completion: ((Bool) -> Void)? = default)` : Switch between child view controllers

### <a id="realmAnchor">`Realm`</a> 💾

#### `DetachableObject`

Simply detach an object from Realm into memmory with its entire properties.

#### `Object`

**For `Object` and `Realm` classes, use the `ex` property to access to the Extra extensions.**

`Queries`

- `static findFirst<T>(in context: Realm? = nil, object type: T.Type = T.self) -> T? where T: Object` : Finds the first object of a specific type
- `static findAll<T>(in context: Realm? = nil, object type: T.Type = T.self) -> Results<T> where T: Object` : Finds all objects of a specific type

`Writes`

- `add(in context: Realm? = nil, update: Bool = true) throws` : Simply writes and adds or update your object in Realm
- `static update<T>(object: T, in context: Realm? = nil) throws where T: Object` : Adds or updates an object in Realm
- `static update<T>(objects: [T], in context: Realm? = nil) throws where T: Object` : Adds or updates many objects in Realm

`Delete`

- `static delete<T>(object: T?, from context: Realm? = nil) throws where T: Object & ObjectRelationDeletable` : Delete an object from Realm
- `static delete<T>(objects: List<T>?, from context: Realm? = nil) throws where T: Object & ObjectRelationDeletable` : Delete many objects from Realm
- `static deleteAll<T>(from context: Realm? = nil, object type: T.Type = T.self) throws where T: Object & ObjectRelationDeletable` : Delete all objects of a specific type from realm

#### `Realm`

- `safeInstance() -> Realm` : Return your [try Realm] instance no-throwable at any time
- `safeInstance(config: Realm.Configuration) -> Realm` : Return your [try Realm] instance no-throwable at any time froma specific configuration

#### `Results`

- `subscript(safe index: Int) -> T? { get }` : Safety getter object on your results
- `ex_toArray() -> [T]` : Return results as a sequence Temporary name

#### `RealmSwift.List`
- `ex_toArray() -> [T]` : Return lsit of object as a sequence Temporary name

## Foundation extensions

### <a id="stringAnchor">`String`</a>

- `heightConstrained(to width: CGFloat, attributes: [String : Any]? = default) -> CGFloat` : Same as boundingRect(), but simplified !
- `isValidEmail() -> Bool` : `[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}`
- `firstCapitalized() -> String` : Capitalize only the first letter of the entire string (localized capitalized)
- `matchesRegex(regex: String) -> Bool` : Check if the string matches to the passed regex
- `base64() -> String?` : Base-64 encoded string

### <a id="collectionAnchor">`MutableCollection`</a>

- `shuffle()` : Shuffles the contents of this collection.

### <a id="sequenceAnchor">`Sequence`</a>

- `shuffled() -> [Iterator.Element]` : Returns an array with the contents of this sequence, shuffled.
- `withoutDuplicates() -> [Iterator.Element]` : Returns an array with the content of this sequence after removing all duplicated elements.

## Author

The iOS Team @Smart&Soft, software agency [http://www.smartnsoft.com](http://www.smartnsoft.com)

## License

Extra is available under the MIT license. See the LICENSE file for more info.
