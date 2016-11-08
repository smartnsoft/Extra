//
//  UITableView+Extra.swift
//  Pods
//
//  Created by Jean-Charles SORIN on 08/11/2016.
//
//

import Foundation

extension UITableView {
  
  
  /// Configure and set the global table HeaderView and correctly set the frame to the fitting size
  ///
  /// - parameter headerView: Your custom header view
  /// - parameter edges:      Specify potential spacing insets
  open func ex_setAndLayoutTableHeaderView(_ headerView: UIView, edges: UIEdgeInsets? = nil) {
    self.tableHeaderView = headerView
    headerView.setNeedsLayout()
    headerView.layoutIfNeeded()
    ex_layoutTableHeaderView(headerView, edges: edges)
  }
  
  /// Automatic height for your header. Call it on didLayoutSubviews
  ///
  /// - parameter headerView: Your custom header view
  /// - parameter edges:      Specify potential spacing insets
  open func ex_layoutTableHeaderView(_ headerView: UIView, edges: UIEdgeInsets? = nil) {
    var horizontalMargins: CGFloat = 0
    var verticalMargins: CGFloat = 0
    if let edges = edges {
      horizontalMargins = edges.left + edges.right
      verticalMargins = edges.top + edges.bottom
    }
    let height = headerView.systemLayoutSizeFitting(CGSize(width: self.frame.width - horizontalMargins,
                                                           height: CGFloat.greatestFiniteMagnitude)).height
    
    var frame = headerView.frame
    frame.size.height = height + verticalMargins
    headerView.frame = frame
    self.tableHeaderView = headerView
  }
  
  
  /// Configure and set the global table FooterView and correctly set the frame to the fitting size
  ///
  /// - parameter footerView: Your custom header view
  /// - parameter edges:      Specify potential spacing insets
  open func ex_setAndLayoutTableFooterView(_ footerView: UIView, edges: UIEdgeInsets? = nil) {
    self.tableFooterView = footerView
    footerView.setNeedsLayout()
    footerView.layoutIfNeeded()
    ex_layoutTableFooterView(footerView, edges: edges)
  }
  
  
  /// Automatic height for your footer. Call it on didLayoutSubviews
  ///
  /// - parameter footerView: Your custom header view
  /// - parameter edges:      Specify potential spacing insets
  open func ex_layoutTableFooterView(_ footerView: UIView, edges: UIEdgeInsets? = nil) {
    var horizontalMargins: CGFloat = 0
    var verticalMargins: CGFloat = 0
    if let edges = edges {
      horizontalMargins = edges.left + edges.right
      verticalMargins = edges.top + edges.bottom
    }
    let height = footerView.systemLayoutSizeFitting(CGSize(width: self.frame.width - horizontalMargins,
                                                           height: CGFloat.greatestFiniteMagnitude)).height
    
    var frame = footerView.frame
    frame.size.height = height + verticalMargins
    footerView.frame = frame
    self.tableFooterView = footerView
  }
}
