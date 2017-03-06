//
//  UINavigationController+Extra.swift
//  Pods
//
//  Created by Jean-Charles SORIN on 08/11/2016.
//
//

import Foundation

extension Extra where Base: UINavigationController {
  
  /// The effect is like a replacement of the current stack, but just the last one UIViewController
  ///
  /// - parameter controller: The view controller to push / for replacement
  public func popPreviousAndPushViewController(_ controller: UIViewController) {

    if !self.base.viewControllers.isEmpty {
      self.base.popViewController(animated: false)
      self.base.pushViewController(controller, animated: false)
    } else {
      self.base.setViewControllers([controller], animated: false)
    }
  }
  
  /// Pop the current stack of Navigation Controller by the specified number
  ///
  /// - parameter numberOf: Number of controllers to pop
  /// - parameter animated: Default is true
  public func popViewControllers(numberOf: Int, animated: Bool = true) {
    
    let subControllers = self.base.viewControllers[0..<numberOf].map { $0 }
    
    self.base.setViewControllers(subControllers, animated: animated)
  }
}
