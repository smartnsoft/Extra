//
//  UIViewController+Extra.swift
//  Pods
//
//  Created by Jean-Charles SORIN on 07/11/2016.
//
//

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
      container.ex.addSubview(childView, insets: insets)
    } else {
      fatalError("Your view controller \(childController) does not contain any view")
    }
    
  }
  
  /// Switch between child view controllers
  ///
  /// - parameter originController:      The potential current controller already displayed in your container view
  /// - parameter destinationController: The new child that will be displayed
  /// - parameter viewContainer:         Your child view container
  /// - parameter duration:              Specify the animation duration. Default 0, set a value > 0 to enable animation
  /// - parameter transitionOptions:     Your switch transition animation options
  public func switchChilds(
    from originController: UIViewController?,
    to destinationController: UIViewController,
    in viewContainer: UIView,
    duration: TimeInterval = 0,
    transitionOptions: UIViewAnimationOptions = .transitionCrossDissolve) {
    
    originController?.willMove(toParentViewController: nil)
    self.base.addChildViewController(destinationController)
    
    if let childView = destinationController.view {
      viewContainer.ex.addSubview(childView, insets: .zero)
    }
    
    if let originController = originController {
      self.base.transition(from: originController,
                           to: destinationController,
                           duration: duration,
                           options: transitionOptions,
                           animations: nil,
                           completion: { _ in
                            originController.removeFromParentViewController()
                            destinationController.didMove(toParentViewController: self.base)
                            
      })
    } else {
      destinationController.view.alpha = 0
      UIView.animate(withDuration: duration, animations: {
        destinationController.view.alpha = 1
      }, completion: { _ in
        destinationController.didMove(toParentViewController: self.base)
      })
    }
  }
  
}
