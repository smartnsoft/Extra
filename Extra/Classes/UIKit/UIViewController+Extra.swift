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

extension Extra where Base: UIViewController {
  
  /// Returns the current application's top most view controller.
  public static func topMost() -> UIViewController? {
    let rootViewController = UIApplication.shared.windows.first?.rootViewController
    return self.topMost(of: rootViewController)
  }
  
  /// Returns the top most view controller from given view controller's stack.
  public static func topMost(of viewController: UIViewController?) -> UIViewController? {
    // UITabBarController
    if let tabBarController = viewController as? UITabBarController,
      let selectedViewController = tabBarController.selectedViewController {
      return self.topMost(of: selectedViewController)
    }
    
    // UINavigationController
    if let navigationController = viewController as? UINavigationController,
      let visibleViewController = navigationController.visibleViewController {
      return self.topMost(of: visibleViewController)
    }
    
    // presented view controller
    if let presentedViewController = viewController?.presentedViewController {
      return self.topMost(of: presentedViewController)
    }
    
    // child view controller
    for subview in viewController?.view?.subviews ?? [] {
      if let childViewController = subview.next as? UIViewController {
        return self.topMost(of: childViewController)
      }
    }
    
    return viewController
  }
  
  /// Simply programmatically adding a child view controller
  ///
  /// - parameter childController: The embeded child view controller
  /// - parameter container:       The destination container view
  /// - parameter insets:          The desired insets betwenn you child and its container
  public func addChildViewController(
    _ childController: UIViewController,
    in container: UIView,
    insets: UIEdgeInsets = .zero) {
    
    if let childView = childController.view {
      self.base.addChildViewController(childController)
      childView.frame = container.bounds
      container.ex.addSubview(childView, insets: insets)
      childController.didMove(toParentViewController: self.base)
    } else {
      fatalError("Your view controller \(childController) does not contain any view")
    }
  }
  
  /// Remove the desired childViewController properly from its parent
  ///
  /// - Parameter childViewController: child controller to remove
  public func removeChildViewController(_ childViewController: UIViewController) {
    childViewController.willMove(toParentViewController: nil)
    childViewController.view.removeFromSuperview()
    childViewController.removeFromParentViewController()
  }
  
  /// Switch between child view controllers
  ///
  /// - parameter originController:      The potential current controller already displayed in your container view
  /// - parameter destinationController: The new child that will be displayed
  /// - parameter viewContainer:         Your child view container
  /// - parameter duration:              Specify the animation duration. Default 0, set a value > 0 to enable animation
  /// - parameter transitionOptions:     Your switch transition animation options
  /// - parameter completion:            Completion block when animation completes
  public func switchChilds(
    from originController: UIViewController?,
    to destinationController: UIViewController,
    in viewContainer: UIView,
    duration: TimeInterval = 0.3,
    transitionOptions: UIViewAnimationOptions = .transitionCrossDissolve,
    insets: UIEdgeInsets = .zero,
    completion: ((Bool) -> Void)? = nil) {
    
    guard destinationController != originController else {
      return
    }
    destinationController.view.frame = viewContainer.bounds
    
    if let originController = originController {
      originController.willMove(toParentViewController: nil)
      self.base.addChildViewController(destinationController)
      self.base.transition(from: originController,
                           to: destinationController,
                           duration: duration,
                           options: transitionOptions,
                           animations: {
                            viewContainer.ex.setSubviewConstraints(destinationController.view)
      },
                           completion: { completed in
                            originController.removeFromParentViewController()
                            destinationController.didMove(toParentViewController: self.base)
                            completion?(completed)
                            
      })
    } else {
      destinationController.view.alpha = 0
      self.addChildViewController(destinationController, in: viewContainer, insets: insets)
      
      UIView.animate(withDuration: duration, animations: {
        destinationController.view.alpha = 1
      }, completion: { finished in
        completion?(finished)
      })
    }
  }
  
  /// Dismiss all presented view controllers recursively.
  ///
  /// - parameter animated:   indicates if all dismiss needs to be animated.
  /// - parameter completion: completion called when all presented view controllers have been dismissed.
  public func dismissAllPresented(animated: Bool = false, completion: (() -> Swift.Void)? = nil) {
    DispatchQueue.main.async {
      if let presentedViewController = self.base.presentedViewController {
        presentedViewController.ex.dismissAllPresented(animated: animated)
        presentedViewController.dismiss(animated: animated, completion: completion)
      } else {
        completion?()
      }
    }
  }
  
}
