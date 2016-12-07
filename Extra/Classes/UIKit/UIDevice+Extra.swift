//
//  UIDevice+Extra.swift
//  Pods
//
//  Created by Jean-Charles SORIN on 08/11/2016.
//
//

import Foundation

extension Extra where Base: UIDevice {
  
  public static func isPad() -> Bool {
    return UIDevice.current.userInterfaceIdiom == .pad
  }
  
  public static func isPhone() -> Bool {
    return UIDevice.current.userInterfaceIdiom == .phone
  }
}
