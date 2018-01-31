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

extension Extra where Base: UIImage {
  
  /// Creates an UIImage from and UIColor
  /// This is useful for your UIButton to set filled background color for states
  ///
  /// - parameter color: Based color for image generation
  /// - parameter size: Based size for image generation
  /// - parameter cornerRadius: Based cornerRadius for image generation
  ///
  /// - returns: UIImage generated for the designated color
  public static func from(color: UIColor, size: CGSize, cornerRadius: CGFloat = 0) -> UIImage? {
    
    let rect = CGRect(origin: CGPoint.zero, size: size)
    
    UIGraphicsBeginImageContext(rect.size)
    
    if cornerRadius != 0 {
      let bezierPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
      bezierPath.addClip()
    }
    
    let context = UIGraphicsGetCurrentContext()
    context?.setFillColor(color.cgColor)
    context?.fill(rect)
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image
  }
  
  /// Transforms the current image to a new one with the CIColorMonochrome filter, with black input color
  ///
  /// - returns: the transformed image in Black&White
  public func toBlackAndWhite() -> UIImage? {
    
    if let ciImage = self.base.ciImage {
      let filterBlackAndWhite = CIFilter(name: "CIColorMonochrome")
      filterBlackAndWhite?.setDefaults()
      filterBlackAndWhite?.setValue(ciImage, forKey: kCIInputImageKey)
      filterBlackAndWhite?.setValue(CIColor.init(red: 1, green: 1, blue: 1),
                                    forKey: "inputColor")
      
      let context = CIContext()
      let outputImage = filterBlackAndWhite?.outputImage
      
      if let output = outputImage, let cgiImageRef = context.createCGImage(output, from: output.extent) {
        let newImage = UIImage(cgImage: cgiImageRef)
        return newImage
      }
    }
    return nil
  }
  
  /// Correctly rotate your image according to the desired degrees
  ///
  /// - parameter degrees: Rotation clock direction
  ///
  /// - returns: Roated original image
  public func imageRotatedByDegrees(degrees: CGFloat) -> UIImage? {
    
    let radians = degrees * CGFloat(Double.pi / 180)
    
    let rotatedViewBox = UIView(frame: CGRect(origin: CGPoint.zero, size: self.base.size))
    let transform = CGAffineTransform(rotationAngle: radians)
    rotatedViewBox.transform = transform
    let rotatedSize = rotatedViewBox.frame.size
    
    UIGraphicsBeginImageContextWithOptions(rotatedSize, false, self.base.scale)
    if let bitmap = UIGraphicsGetCurrentContext() {
      
      bitmap.translateBy(x: (rotatedSize.width / 2), y: (rotatedSize.height / 2))
      bitmap.rotate(by: radians)
      bitmap.scaleBy(x: 1.0, y: -1.0)
    }
    
    self.base.draw(at: CGPoint(x: (-rotatedSize.width / 2), y: (-rotatedSize.height / 2)))
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
  }
  
  /// This will resize the UIImage to the destination size
  /// This will fill your UIImage (and potentially enlarge it)
  /// By this way, this will not produce empty space on top/bottom or left/right sides, the ratio will not change
  ///
  /// - parameter size: Your size into fit/resize your original UIImage
  ///
  /// - returns: Resized image
  public func scaledFilledToSize(size: CGSize) -> UIImage? {
    
    let scale = UIScreen.main.scale
    UIGraphicsBeginImageContextWithOptions(size, false, scale)
    
    let oldWidth = self.base.size.width
    let oldHeight = self.base.size.height
    
    let scaleFactor = (oldWidth > oldHeight) ? size.width / oldWidth : size.height / oldHeight
    
    var newHeight = oldHeight * scaleFactor
    var newWidth = oldWidth * scaleFactor
    
    if newHeight < size.height {
      let ratio = (size.height/newHeight)
      newHeight *= ratio
      newWidth *= ratio
    }
    
    if newWidth < size.width {
      let ratio = (size.width/newWidth)
      newHeight *= ratio
      newWidth *= ratio
    }
    
    self.base.draw(in: CGRect(x: 0, y: 0,
                              width: newWidth, height: newHeight))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage
  }
  
  /// Simple resize of your image based to it center
  ///
  /// - returns: Resized image
  public func resizableImageByCenter() -> UIImage {
    
    let topBottom = self.base.size.height / 2
    let leftRight = self.base.size.width / 2
    let capInsets = UIEdgeInsets(top: topBottom,
                                 left: leftRight,
                                 bottom: topBottom,
                                 right: leftRight)
    
    return self.base.resizableImage(withCapInsets: capInsets)
  }
  
  public func filled(withOverlayColor color: UIColor, ratio: CGFloat) -> UIImage {
    let height = self.base.size.height * min(ratio, 1.0)
    let rect = CGRect(origin: CGPoint.zero, size: self.base.size)
    
    UIGraphicsBeginImageContextWithOptions(self.base.size, false, 0.0)
    self.base.draw(in: rect)
    
    guard let context = UIGraphicsGetCurrentContext() else {
      fatalError("Unable to retrieve a context to draw")
    }
    context.setBlendMode(.sourceIn)
    context.setFillColor(color.cgColor)
    
    let fillRect = CGRect(x: 0.0,
                          y: self.base.size.height - height,
                          width: self.base.size.width,
                          height: height)
    context.fill(fillRect)
    
    guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
      fatalError("Unable to get image from context")
    }
    UIGraphicsEndImageContext()
    
    return image
  }
  
  /// Creates a scaled copy of the image according to specified factor.
  ///
  /// - Parameter factor: Scaled factor
  ///
  /// - Returns: Scaled copy of the image
  func scaleImage(toFactor factor: CGFloat) -> UIImage? {
    
    guard let cgImage = self.base.cgImage, let colorSpace = cgImage.colorSpace else {
      return nil
    }
    
    let iFactor = Int(factor)
    
    let width = cgImage.width / iFactor
    let height = cgImage.height / iFactor
    let bitsPerComponent = cgImage.bitsPerComponent
    let bytesPerRow = cgImage.bytesPerRow
    let bitmapInfo = cgImage.bitmapInfo
    
    if let context = CGContext(data: nil,
                               width: width,
                               height: height,
                               bitsPerComponent: bitsPerComponent,
                               bytesPerRow: bytesPerRow,
                               space: colorSpace,
                               bitmapInfo: bitmapInfo.rawValue) {
      
      context.interpolationQuality = CGInterpolationQuality.high
      
      context.draw(cgImage, in: CGRect(origin: .zero,
                                       size: CGSize(width: CGFloat(width),
                                                    height: CGFloat(height))))
      
      return context.makeImage().flatMap { UIImage(cgImage: $0) }
    }
    
    return nil
  }
  
  /// Cut and return a tile in the image with specified rect.
  ///
  /// - Parameter rect: Rect to cut
  ///
  /// - Returns: Cut tile
  public func cutTile(with rect: CGRect) -> UIImage? {
    guard let cgImage = self.base.cgImage,
      let image = cgImage.cropping(to: rect) else {
      return nil
    }
    
    return UIImage(cgImage: image)
  }
  
  /// Creates a copy of the image simulating aspect fill to specified size
  ///
  /// - Parameter size: Size of the required image
  ///
  /// - Returns: Copy of the image after aspect fill
  public func scaledAspectFill(to size: CGSize) -> UIImage? {
    let aspectWidth = size.width / self.base.size.width
    let aspectHeight = size.height / self.base.size.height
    let aspectRatio = max(aspectWidth, aspectHeight)
    var rect = CGRect.zero
    rect.size.width = self.base.size.width * aspectRatio
    rect.size.height = self.base.size.height * aspectRatio
    rect.origin.x = (size.width - rect.size.width) / 2.0
    rect.origin.y = (size.height - rect.size.height) / 2.0
    UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
    self.base.draw(in: rect)
    let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return scaledImage
  }
}
