//
//  UIView+Extra.swift
//  Pods
//
//  Created by Jean-Charles SORIN on 07/11/2016.
//
//

public enum ExtraGradientDirection {
  case horizontalToRight, horizontalToLeft, verticalToTop, verticalToBottom
  
  var startPoint: CGPoint {
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
  
  var endPoint: CGPoint {
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

extension UIView {
  
  open var top: CGFloat {
    return self.frame.origin.y
  }
  
  open var left: CGFloat {
    return self.frame.origin.x
  }
  
  open var bottom: CGFloat {
    return self.frame.origin.y + self.height
  }
  
  open var right: CGFloat {
    return self.frame.origin.x + self.width
  }
  
  open var width: CGFloat {
    return self.frame.width
  }
  
  open var height: CGFloat {
    return self.frame.height
  }
  
  open func ex_initXib() {
    let view = ex_instantiateFromNib()
    view.frame = bounds
    view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    addSubview(view)
  }
  
  open func ex_instantiateFromNib() -> UIView {
    let nibName = String(describing: type(of: self))
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: nibName, bundle: bundle)
    guard let view: UIView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else {
      fatalError("Unable to get the root view using instantiateWithOwner")
    }
    return view
  }
  
  open func ex_addSubview(_ subview: UIView, insets: UIEdgeInsets) {
    subview.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(subview)
    
    let hConstraint = "H:|-\(insets.left)-[view]-\(insets.right)-|"
    let vConstraint = "V:|-\(insets.top)-[view]-\(insets.bottom)-|"
    
    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: hConstraint,
                                                       options: NSLayoutFormatOptions(rawValue: 0),
                                                       metrics: nil,
                                                       views: ["" : subview]))
    
    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: vConstraint,
                                                       options: NSLayoutFormatOptions(rawValue: 0),
                                                       metrics: nil,
                                                       views: ["" : subview]))
  }
  
  open func ex_removeAllSubViews() {
    let allSubviews = self.subviews
    
    for view in allSubviews {
      view.removeFromSuperview()
    }
  }
  
  open func ex_setAllSubviewsHidden(_ hidden: Bool) {
    self.subviews.forEach { (view) in
      view.isHidden = hidden
    }
  }
  
  open func ex_addClearToDarkGradient(radius: CGFloat = 0, direction: ExtraGradientDirection) {
    let gradient = CAGradientLayer()
    gradient.masksToBounds = true
    gradient.cornerRadius = radius
    gradient.frame = self.bounds
    gradient.startPoint = direction.startPoint
    gradient.endPoint   = direction.endPoint
    gradient.locations  = [0, 0.25, 0.75, 1]
    gradient.colors = [UIColor(white: 1, alpha: 1).cgColor,
                       UIColor(white: 1, alpha: 0.9).cgColor,
                       UIColor(white: 1, alpha: 0.35).cgColor,
                       UIColor.clear.cgColor]
    
    self.layer.mask = gradient
  }
  
}
