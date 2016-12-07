//
//  UIApplication+Extra.swift
//  Pods
//
//  Created by Jean-Charles SORIN on 08/11/2016.
//
//

extension Extra where Base: UIApplication {
  
  public static func showActivityIndicator() {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
  }
  
  public static func hideActivityIndicator() {
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
  }
  
}
