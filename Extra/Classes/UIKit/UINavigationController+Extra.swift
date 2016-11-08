//
//  UINavigationController+Extra.swift
//  Pods
//
//  Created by Jean-Charles SORIN on 08/11/2016.
//
//

import Foundation

extension UINavigationController {
  
  
  /// The effect is like a replacement of the current stack, but just the last one UIViewController
  ///
  /// - parameter controller: The view controller to push / for replacement
  open func ex_popPreviousAndPushViewController(_ controller: UIViewController) {
    if !self.viewControllers.isEmpty {
      self.popViewController(animated: false)
      self.pushViewController(controller, animated: false)
    } else {
      self.setViewControllers([controller], animated: false)
    }
  }
  
  
  /// Pop the current stack of Navigation Controller by the specified number
  ///
  /// - parameter numberOf: Number of controllers to pop
  /// - parameter animated: Default is true
  open func ex_popViewControllers(numberOf: Int, animated: Bool = true) {
    
    let subControllers = self.viewControllers[0..<numberOf].map { $0 }
    
    self.setViewControllers(subControllers, animated: animated)
  }
}
