![](./Images/logo_Extra.png)

# Extra 👌🏼

[![CI Status](http://img.shields.io/travis/smartnsoft/Extra.svg?style=flat)](https://travis-ci.org/smartnsoft/Extra)
[![Version](https://img.shields.io/cocoapods/v/Extra.svg?style=flat)](http://cocoapods.org/pods/Extra)
[![License](https://img.shields.io/cocoapods/l/Extra.svg?style=flat)](http://cocoapods.org/pods/Extra)
[![Platform](https://img.shields.io/cocoapods/p/Extra.svg?style=flat)](http://cocoapods.org/pods/Extra)

A Swift 3 library with usefull and lightfull extensions for your Cocoa Touch projects.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 9+
- Xcode 8+, Swift 3

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

## Usage

**Use the `ex` variable on your current type to access to the Extra methods :**

`UIApplication.ex.hideActivityIndicator()`

## Quick focus on available extensions

### UIKit extensions 🎨

####  `UIApplication`
-  `UIActivityIndicator` accessbility : `hideActivityIndicator()` / `showActivityIndicator()`

####  `UICollectionView`

-  `currentIndexPathForCenter()` : return the index path of cell displayed at the center(x,y) of the UICollectionView
-  `public func scrollVertically(to: IndexPath, accordingTo: IndexPath, animated: Bool = default)` : scroll to an item an be sur to let the other be vivisble if possible
	
####  `UICollectionViewCell`

-  `collectionView` property : return the current UICollectionView related to the cell

####  `UIColor`

-  `toImage(size: CGSize = default) -> UIImage?` : Transform the current color to a sizable UIImage
-  `fromHexa(_ hexaString: String, alpha: CGFloat = default) -> UIColor?` : Create a color from an hexa string

####  `UIDevice`

-  `isPad` / `isPhone` quick access

####  `UIImage`

-  `from(color: UIColor, size: CGSize, cornerRadius: CGFloat = default) -> UIImage?` : Creates an UIImage from and UIColor This is usefull for your UIButton to set filled background color for states.
-  `toBlackAndWhite() -> UIImage?` : Transforms the current image to a new one with the `CIColorMonochrome` filter, with black input color.
-  `imageRotatedByDegrees(degrees: CGFloat) -> UIImage?` : Correctly rotate your image according to the desired degrees.
-  `scaledFilledToSize(size: CGSize) -> UIImage?` : This will resize the UIImage to the destination size This will fill your UIImage (and potentially enlarge it) By this way, this will not produce empty space on top/bottom or left/right sides, the ratio will not change.
-  `resizableImageByCenter() -> UIImage` : Simple reisze of your image based to it center.
	
####  `UINavigationController`

-  `popPreviousAndPushViewController(_ controller: UIViewController)` : The effect is like a replacement of the current stack, but just the last one UIViewController.
-  `popViewControllers(numberOf: Int, animated: Bool = default)` : Pop the current stack of Navigation Controller by the specified number.

####  `UITableView`

-  `setAndLayoutTableHeaderView(_ headerView: UIView, edges: UIEdgeInsets? = default)` : Configure and set the global table HeaderView and correctly set the frame to the fitting size
-  `layoutTableHeaderView(_ headerView: UIView, edges: UIEdgeInsets? = default)` : Automatic height for your header. Call it on didLayoutSubviews
-  `setAndLayoutTableFooterView(_ footerView: UIView, edges: UIEdgeInsets? = default)` : Configure and set the global table FooterView and correctly set the frame to the fitting size
-  `layoutTableFooterView(_ footerView: UIView, edges: UIEdgeInsets? = default)` : Automatic height for your footer. Call it on didLayoutSubviews

####  `UITableViewCell`

-  `tableView` property : return the current UICollectionView related to the cell

####  `UIView`

-  `initXib()` : Use this method in your custom UIView with a specified Xib, to add your xib content at creation
-  `instantiateFromNib() -> UIView` : Create and retrieve the root UIView of your Xib based on the current UIView class name
-  `addSubview(_ subview: UIView, insets: UIEdgeInsets)` : Add a subview into the current UIView with potential insets.
-  `removeAllSubViews()` : Recursively remove all your related subviews
-  `setAllSubviewsHidden(_ hidden: Bool)` : Recursively hide all your related subviews
-  `addClearToDarkGradient(radius: CGFloat = default, direction: ExtraGradientDirection)` : This will create a gradient into your current UIView (so this is available for UIImageView) Be sure to have a background color dark to have good results
-  `roundCorners(_ corners: UIRectCorner, radius: CGSize)` : Apply a rounded mask to the current view
	
####  `UIViewController`

-  `topMost() -> UIViewController?` : Returns the current application’s top most view controller.
-  `addChildViewController(_ childController: UIViewController, in container: UIView, insets: UIEdgeInsets = default)` : Simply programmatically adding a child view controller
-  `switchChilds(from originController: UIViewController?, to destinationController: UIViewController, in viewContainer: UIView, duration: TimeInterval = default, transitionOptions: UIViewAnimationOptions = default, completion: ((Bool) -> Void)? = default)` : Switch between child view controllers

### Realm extensions 💾

#### `DetachableObject`

Simply detach an object from Realm into memmory with its entire properties.

#### `Object`

**For `Object` and `Realm` classes, use the `ex` property to access to the Extra extensions.**

- `add(in inRealm: Realm? = default, update: @escaping Bool = default) throws` : Simply write and add your update in Realm

#### `Realm`

- `safeInstance() -> Realm` : Return your [try Realm] instance no-throwable at any time
- `safeInstance(config: Realm.Configuration) -> Realm` : Return your [try Realm] instance no-throwable at any time froma specific configuration

#### `Results`

- `subscript(safe index: Int) -> T? { get }` : Safety getter object on your results
- `ex_toArray() -> [T]` : Return results as a sequence Temporary name

#### `RealmSwift.List`
- `ex_toArray() -> [T]` : Return lsit of object as a sequence Temporary name

### Foundation extensions 

#### `String`

- `heightConstrained(to width: CGFloat, attributes: [String : Any]? = default) -> CGFloat` : Same as boundingRect(), but simplified !
- `isValidEmail() -> Bool` : `[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}`
- `firstCapitalized() -> String` : Capitalize only the first letter of the entire string (localized capitalized)
- `matchesRegex(regex: String) -> Bool` : Check if the string matches to the passed regex

#### `MutableCollection`

- `shuffle()` : Shuffles the contents of this collection.

#### `Sequence`

- `shuffled() -> [Iterator.Element]` : Returns an array with the contents of this sequence, shuffled.

## Author

The iOS Team @Smart&Soft, software agency [http://www.smartnsoft.com](http://www.smartnsoft.com)

## License

Extra is available under the MIT license. See the LICENSE file for more info.
