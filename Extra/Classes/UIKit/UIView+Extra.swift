//
//  UIView+Extra.swift
//  Pods
//
//  Created by Jean-Charles SORIN on 07/11/2016.
//
//

extension UIView {
  open func addSubview(_ subview: UIView, insets: UIEdgeInsets) {
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
}
