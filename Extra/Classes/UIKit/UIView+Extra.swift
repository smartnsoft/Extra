//
//  UIView+Extra.swift
//  Pods
//
//  Created by Jean-Charles SORIN on 07/11/2016.
//
//


/// Gradient directon to explain vertical/horizontal Y axis for a gradient, and X axis direction
public enum ExtraGradientDirection {
  case horizontalToRight, horizontalToLeft, verticalToTop, verticalToBottom
  
  public var startPoint: CGPoint {
    switch self {
    case .verticalToBottom:
      return CGPoint(x: 0.5, y: 0)
    case .verticalToTop:
      return CGPoint(x: 0.5, y: 1)
    case .horizontalToLeft:
      return CGPoint(x: 1, y: 0.5)
    case .horizontalToRight:
      return CGPoint(x: 0, y: 0.5)
    }
  }
  
  public var endPoint: CGPoint {
    switch self {
    case .verticalToBottom:
      return CGPoint(x: 0.5, y: 1)
    case .verticalToTop:
      return CGPoint(x: 0.5, y: 0)
    case .horizontalToLeft:
      return CGPoint(x: 0, y: 0.5)
    case .horizontalToRight:
      return CGPoint(x: 1, y: 0.5)
    }
  }
}

extension Extra where Base: UIView {
  

  /// Use this method in your custom UIView with a specified Xib, to add your xib content at creation
  public func initXib() {
    let view = instantiateFromNib()
    view.frame = self.base.bounds
    view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    self.base.addSubview(view)
  }
  
  
  /// Create and retrieve the root UIView of your Xib based on the current UIView class name
  ///
  /// - returns: The root view of your Xib
  public func instantiateFromNib() -> UIView {
    let nibName = String(describing: type(of: self))
    let bundle = Bundle(for: type(of: self.base))
    let nib = UINib(nibName: nibName, bundle: bundle)
    guard let view: UIView = nib.instantiate(withOwner: self.base, options: nil)[0] as? UIView else {
      fatalError("Unable to get the root view using instantiateWithOwner")
    }
    return view
  }
  
  
  /// Add a subview into the current UIView with potential insets.
  ///
  /// - parameter subview: Child view
  /// - parameter insets:  Insets explainded between the child and your current view
  public func addSubview(_ subview: UIView, insets: UIEdgeInsets) {
    subview.translatesAutoresizingMaskIntoConstraints = false
    self.base.addSubview(subview)
    
    let hConstraint = "H:|-\(insets.left)-[view]-\(insets.right)-|"
    let vConstraint = "V:|-\(insets.top)-[view]-\(insets.bottom)-|"
    
    self.base.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: hConstraint,
                                                       options: NSLayoutFormatOptions(rawValue: 0),
                                                       metrics: nil,
                                                       views: ["" : subview]))
    
    self.base.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: vConstraint,
                                                       options: NSLayoutFormatOptions(rawValue: 0),
                                                       metrics: nil,
                                                       views: ["" : subview]))
  }
  
  
  /// Recursively remove all your related subviews
  public func removeAllSubViews() {
    let allSubviews = self.base.subviews
    
    for view in allSubviews {
      view.removeFromSuperview()
    }
  }
  
  
  /// Recursively hide all your related subviews
  ///
  /// - parameter hidden: True to hide all your subviews
  public func setAllSubviewsHidden(_ hidden: Bool) {
    self.base.subviews.forEach { (view) in
      view.isHidden = hidden
    }
  }
  
  
  /// This will create a gradient into your current UIView (so this is available for UIImageView)
  /// Be sure to have a background color dark to have good results
  ///
  /// - parameter radius:    If you want to specify radius according to your parent view
  /// - parameter direction: see ExtraGradientDirection
  public func addClearToDarkGradient(radius: CGFloat = 0, direction: ExtraGradientDirection) {
    let gradient = CAGradientLayer()
    gradient.masksToBounds = true
    gradient.cornerRadius = radius
    gradient.frame = self.base.bounds
    gradient.startPoint = direction.startPoint
    gradient.endPoint   = direction.endPoint
    gradient.locations  = [0, 0.25, 0.75, 1]
    gradient.colors = [UIColor(white: 1, alpha: 1).cgColor,
                       UIColor(white: 1, alpha: 0.9).cgColor,
                       UIColor(white: 1, alpha: 0.35).cgColor,
                       UIColor.clear.cgColor]
    
    self.base.layer.mask = gradient
  }
  
}
