//
//  UIApplication+Extra.swift
//  Pods
//
//  Created by Jean-Charles SORIN on 08/11/2016.
//
//

extension UIApplication {
  static func ex_showActivityIndicator() {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
  }
  static func ex_hideActivityIndicator() {
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
  }
}
