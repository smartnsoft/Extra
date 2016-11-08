//
//  UIImage+Extra.swift
//  Pods
//
//  Created by Jean-Charles SORIN on 08/11/2016.
//
//

import Foundation

extension UIImage {
  
  
  /// Creates an UIImage from and UIColor
  /// This is usefull for your UIButton to set filled background color for states
  ///
  /// - parameter color: Based color for image generation
  ///
  /// - returns: UIImage generated for the designated color
  open static func ex_from(color: UIColor) -> UIImage? {
    let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
    
    UIGraphicsBeginImageContext(rect.size)
    
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
  open func ex_toBlackAndWhite() -> UIImage? {
    
    if let ciImage = self.ciImage {
      let filterBlackAndWhite = CIFilter(name: "CIColorMonochrome")
      filterBlackAndWhite?.setDefaults()
      filterBlackAndWhite?.setValue(ciImage, forKey: kCIInputImageKey)
      filterBlackAndWhite?.setValue(CIColor.init(red: 1, green: 1, blue: 1), forKey: "inputColor")
      
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
  open func ex_imageRotatedByDegrees(degrees: CGFloat) -> UIImage? {
    
    let radians = degrees * CGFloat(M_PI / 180)
    
    let rotatedViewBox = UIView(frame: CGRect(origin: CGPoint.zero, size: self.size))
    let transform = CGAffineTransform(rotationAngle: radians)
    rotatedViewBox.transform = transform
    let rotatedSize = rotatedViewBox.frame.size
    
    UIGraphicsBeginImageContextWithOptions(rotatedSize, false, self.scale)
    if let bitmap = UIGraphicsGetCurrentContext() {
    
    bitmap.translateBy(x: (rotatedSize.width / 2), y: (rotatedSize.height / 2))
    bitmap.rotate(by: radians)
    bitmap.scaleBy(x: 1.0, y: -1.0)
    }
    
    self.draw(at: CGPoint(x: (-rotatedSize.width / 2), y: (-rotatedSize.height / 2)))
    
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
  open func ex_scaledFilledToSize(size: CGSize) -> UIImage? {
    let scale = UIScreen.main.scale
    UIGraphicsBeginImageContextWithOptions(size, false, scale)
    
    let oldWidth = self.size.width
    let oldHeight = self.size.height
    
    let scaleFactor = (oldWidth > oldHeight) ? size.width / oldWidth : size.height / oldHeight
    
    var newHeight = oldHeight * scaleFactor
    var newWidth = oldWidth * scaleFactor
    
    if newHeight < size.height {
      let ratio = (size.height/newHeight)
      newHeight = newHeight * ratio
      newWidth = newWidth * ratio
    }
    
    if newWidth < size.width {
      let ratio = (size.width/newWidth)
      newHeight = newHeight * ratio
      newWidth = newWidth * ratio
    }
    
    self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage
  }
  
  
  /// Simple reisze of your image based to it center
  ///
  /// - returns: 
  open func ex_resizableImageByCenter() -> UIImage {
    let topBottom = self.size.height / 2
    let leftRight = self.size.width / 2
    let capInsets = UIEdgeInsets(top: topBottom, left: leftRight, bottom: topBottom, right: leftRight)
    
    return self.resizableImage(withCapInsets: capInsets)
  }
  
  open func ex_filled(withOverlayColor color: UIColor, ratio: CGFloat) -> UIImage {
    let height = self.size.height * min(ratio, 1.0)
    let rect = CGRect(origin: CGPoint.zero, size: self.size)
    
    UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
    draw(in: rect)
    
    guard let context = UIGraphicsGetCurrentContext() else {
      fatalError("Unable to retrieve a context to draw")
    }
    context.setBlendMode(.sourceIn)
    context.setFillColor(color.cgColor)
    
    let fillRect = CGRect(x: 0.0, y: self.size.height - height, width: self.size.width, height: height)
    context.fill(fillRect)
    
    guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
      fatalError("Unable to get image from context")
    }
    UIGraphicsEndImageContext()
    
    return image
  }
  
  //temp
  func ex_scaleImage(toFactor factor: CGFloat) -> UIImage? {
    
    guard let cgImage = self.cgImage, let colorSpace = cgImage.colorSpace else {
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
}
