//
//  UINavigationController+Extra.swift
//  Pods
//
//  Created by Jean-Charles SORIN on 08/11/2016.
//
//

import Foundation

extension UINavigationController {
  
  open func ex_popPreviousAndPushViewController(_ controller: UIViewController) {
    if !self.viewControllers.isEmpty {
      self.popViewController(animated: false)
      self.pushViewController(controller, animated: false)
    } else {
      self.setViewControllers([controller], animated: false)
    }
  }
  
  open func ex_popViewControllers(numberOf: Int, animated: Bool = true) {
    
    let subControllers = self.viewControllers[0..<numberOf].map { $0 }
    
    self.setViewControllers(subControllers, animated: animated)
  }
}
