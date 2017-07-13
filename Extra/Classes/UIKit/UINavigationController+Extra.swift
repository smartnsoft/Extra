// The MIT License (MIT)
//
// Copyright (c) 2017 Smart&Soft
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

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
