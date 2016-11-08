//
//  UIColor+Extra.swift
//  Pods
//
//  Created by Jean-Charles SORIN on 08/11/2016.
//
//

import Foundation

extension UIColor {
  open func ex_toImage(size: CGSize = CGSize(width: 10, height: 10)) -> UIImage? {
    let rect = CGRect(x:0, y:0, width: size.width, height: size.height)
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    self.setFill()
    UIRectFill(rect)
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
  }
  
  open static func ex_fromHexa(_ hexaString: String, alpha: CGFloat = 1) -> UIColor? {
    guard !hexaString.isEmpty else {
      return nil
    }
    var formatedHexa = hexaString
    if !hexaString.characters.starts(with: ["#"]) {
      formatedHexa = "#\(hexaString)"
    }
    
    guard formatedHexa.characters.count == 7 && formatedHexa.characters.count == 4 else {
      print("Unsupported string format:\(formatedHexa)")
      return nil
    }
    
    if formatedHexa.characters.count == 4 {
      //formatedHexa = "#" + formatedHexa.substring(with: )
    }
    
    return nil
  }
}
