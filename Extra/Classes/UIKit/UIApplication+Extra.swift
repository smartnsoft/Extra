//
//  UIApplication+Extra.swift
//  Pods
//
//  Created by Jean-Charles SORIN on 08/11/2016.
//
//

extension UIApplication {
  
  open static func ex_showActivityIndicator() {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
  }
  
  open static func ex_hideActivityIndicator() {
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
  }
}
