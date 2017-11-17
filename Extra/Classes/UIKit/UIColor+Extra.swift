// The MIT License (MIT)
//
// Copyright (c) 2017 Smart&Soft
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation

extension Extra where Base: UIColor {
  
  /// Transform the current color to a sizable UIImage
  ///
  /// - parameter size: the desired size, default is 10/10
  ///
  /// - returns: The filled color image
  public func toImage(size: CGSize = CGSize(width: 10, height: 10)) -> UIImage? {
    
    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    self.base.setFill()
    UIRectFill(rect)
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
  }
  
  /// Create a color from an hexa string
  ///
  /// - parameter hexaString: #1234 or #123456 or without # character
  /// - parameter alpha:      the desired transparence
  ///
  /// - returns: generated UIColor
  public static func fromHexa(_ hexaString: String, alpha: CGFloat = 1) -> UIColor? {
    
    guard !hexaString.isEmpty else {
      return nil
    }
    var formatedHexa = hexaString
    if !hexaString.starts(with: ["#"]) {
      formatedHexa = "#\(hexaString)"
    }
    
    guard formatedHexa.count == 7 || formatedHexa.count == 4 else {
      print("Unsupported string format:\(formatedHexa)")
      return nil
    }
    
    if formatedHexa.count == 4 {
      
      let hexaString = formatedHexa as NSString
      formatedHexa = "#"
        + hexaString.substring(with: NSRange(location: 1, length: 1))
        + hexaString.substring(with: NSRange(location: 1, length: 1))
        + hexaString.substring(with: NSRange(location: 2, length: 1))
        + hexaString.substring(with: NSRange(location: 2, length: 1))
        + hexaString.substring(with: NSRange(location: 3, length: 1))
        + hexaString.substring(with: NSRange(location: 3, length: 1))
    }
    
    let hexaString = formatedHexa as NSString
    
    let redHex = "0x" + hexaString.substring(with: NSRange(location: 1, length: 2))
    let greenHex = "0x" + hexaString.substring(with: NSRange(location: 3, length: 2))
    let blueHex = "0x" + hexaString.substring(with: NSRange(location: 5, length: 2))
    
    var red: UInt32 = 0
    Scanner(string: redHex).scanHexInt32(&red)
    
    var green: UInt32 = 0
    Scanner(string: greenHex).scanHexInt32(&green)
    
    var blue: UInt32 = 0
    Scanner(string: blueHex).scanHexInt32(&blue)
    
    let color = UIColor(red: CGFloat(red) / 255,
                        green: CGFloat(green) / 255,
                        blue: CGFloat(blue) / 255,
                        alpha: alpha)
    
    return color
  }
}
