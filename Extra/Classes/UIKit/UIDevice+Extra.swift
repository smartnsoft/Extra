//
//  UIDevice+Extra.swift
//  Pods
//
//  Created by Jean-Charles SORIN on 08/11/2016.
//
//

import Foundation

extension UIDevice {
  static func ex_isPad() -> Bool {
    return UIDevice.current.userInterfaceIdiom == .pad
  }
  
  static func ex_isPhone() -> Bool {
    return UIDevice.current.userInterfaceIdiom == .phone
  }
}
