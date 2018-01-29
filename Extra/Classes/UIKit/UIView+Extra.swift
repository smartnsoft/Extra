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
    
    let nibName = String(describing: type(of: self.base))
    let bundle = Bundle(for: type(of: self.base))
    let nib = UINib(nibName: nibName, bundle: bundle)
    guard let view: UIView = nib.instantiate(withOwner: self.base, options: nil).first as? UIView else {
      fatalError("Unable to get the root view using instantiateWithOwner")
    }
    return view
  }
  
  /// Add a subview into the current UIView with potential insets.
  ///
  /// - parameter subview: Child view
  /// - parameter insets:  Insets explainded between the child and your current view
  public func addSubview(_ subview: UIView, insets: UIEdgeInsets = .zero) {
    self.base.addSubview(subview)
    self.setSubviewConstraints(subview)
  }
  
  /// Set constraints to the added subview .
  ///
  /// - parameter subview: Child view
  /// - parameter insets:  Insets explainded between the child and your current view
  public func setSubviewConstraints(_ subview: UIView, insets: UIEdgeInsets = .zero) {
    
    guard subview.superview != nil else {
      return
    }
    subview.translatesAutoresizingMaskIntoConstraints = false
    
    let hConstraint = "H:|-\(insets.left)-[subview]-\(insets.right)-|"
    let vConstraint = "V:|-\(insets.top)-[subview]-\(insets.bottom)-|"
    
    self.base.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: hConstraint,
                                                            options: NSLayoutFormatOptions(rawValue: 0),
                                                            metrics: nil,
                                                            views: ["subview": subview]))
    
    self.base.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: vConstraint,
                                                            options: NSLayoutFormatOptions(rawValue: 0),
                                                            metrics: nil,
                                                            views: ["subview": subview]))
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
  
  /// Set a rounded style to the layer's mask of the current view
  ///
  /// - Parameters:
  ///   - corners: corners target
  ///   - radius: radius to apply for corners
  public func setRoundedMask(corners: UIRectCorner, radius: CGSize) {
    let maskPath = UIBezierPath(roundedRect: self.base.bounds, byRoundingCorners: corners, cornerRadii: radius)
    let maskLayer = CAShapeLayer()
    maskLayer.frame = self.base.bounds
    maskLayer.path = maskPath.cgPath
    
    self.base.layer.mask = maskLayer
  }
  
  /// Set a dashed style to the layer's mask around the current view
  ///
  /// - Parameters:
  ///   - color: color of the dashed traits
  ///   - thickness: thickness of the dashed traits
  public func addDashedBorder(color: CGColor = UIColor.black.cgColor, thickness: CGFloat = 2) {
    
    let shapeLayer: CAShapeLayer = CAShapeLayer()
    let frameSize = self.base.frame.size
    let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
    
    shapeLayer.bounds = shapeRect
    shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
    shapeLayer.fillColor = UIColor.clear.cgColor
    shapeLayer.strokeColor = color
    shapeLayer.lineWidth = thickness
    shapeLayer.lineJoin = kCALineJoinRound
    shapeLayer.lineDashPattern = [6, 3]
    shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
    
    self.base.layer.addSublayer(shapeLayer)
  }
  
  /// Set a shadow to the current view on left, right and bottom edges
  public func addShadowBorder(color: UIColor = .black, size: CGFloat = 3) {
    self.base.layer.masksToBounds = false
    self.base.layer.shadowColor = color.cgColor
    self.base.layer.shadowOpacity = 0.2
    self.base.layer.shadowOffset = .zero
    self.base.layer.shadowRadius = 1
    
    let shadowSize: CGFloat = size
    
    let rect = CGRect(x: -shadowSize / 2,
                      y: 0,
                      width: self.base.frame.width + shadowSize,
                      height: self.base.frame.height + shadowSize / 2)
    self.base.layer.shadowPath = UIBezierPath(rect: rect).cgPath
  }
  
  /// Add a bottom divider line to the current view
  ///
  /// - Parameters:
  ///   - color: divider color
  ///   - alpha: divider alpha
  ///   - widthMultiplier: divider width by report to its parent view
  public func addBottomDivider(color: UIColor = .black, alpha: CGFloat = 0.3, thickness: CGFloat = 1, widthMultiplier: CGFloat = 0.85) {
    let divider = UIView()
    divider.translatesAutoresizingMaskIntoConstraints = false
    divider.backgroundColor = color
    divider.alpha = alpha
    self.base.addSubview(divider)

    [ divider.widthAnchor.constraint(equalTo: self.base.widthAnchor, multiplier: widthMultiplier),
      divider.heightAnchor.constraint(equalToConstant: thickness),
      divider.centerXAnchor.constraint(equalTo: self.base.centerXAnchor),
      divider.bottomAnchor.constraint(equalTo: self.base.bottomAnchor)
      ].forEach { $0.isActive = true }
  }
  
}
