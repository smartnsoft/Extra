//
//  UITableView+Extra.swift
//  Pods
//
//  Created by Jean-Charles SORIN on 08/11/2016.
//
//

import Foundation

extension Extra where Base: UITableView {
  
  
  /// Configure and set the global table HeaderView and correctly set the frame to the fitting size
  ///
  /// - parameter headerView: Your custom header view
  /// - parameter edges:      Specify potential spacing insets
  public func setAndLayoutTableHeaderView(_ headerView: UIView, edges: UIEdgeInsets? = nil) {
    self.base.tableHeaderView = headerView
    headerView.setNeedsLayout()
    headerView.layoutIfNeeded()
    self.layoutTableHeaderView(headerView, edges: edges)
  }
  
  /// Automatic height for your header. Call it on didLayoutSubviews
  ///
  /// - parameter headerView: Your custom header view
  /// - parameter edges:      Specify potential spacing insets
  public func layoutTableHeaderView(_ headerView: UIView, edges: UIEdgeInsets? = nil) {
    var horizontalMargins: CGFloat = 0
    var verticalMargins: CGFloat = 0
    if let edges = edges {
      horizontalMargins = edges.left + edges.right
      verticalMargins = edges.top + edges.bottom
    }
    let height = headerView.systemLayoutSizeFitting(CGSize(width: self.base.frame.width - horizontalMargins,
                                                           height: CGFloat.greatestFiniteMagnitude)).height
    
    var frame = headerView.frame
    frame.size.height = height + verticalMargins
    headerView.frame = frame
    self.base.tableHeaderView = headerView
  }
  
  
  /// Configure and set the global table FooterView and correctly set the frame to the fitting size
  ///
  /// - parameter footerView: Your custom header view
  /// - parameter edges:      Specify potential spacing insets
  public func setAndLayoutTableFooterView(_ footerView: UIView, edges: UIEdgeInsets? = nil) {
    self.base.tableFooterView = footerView
    footerView.setNeedsLayout()
    footerView.layoutIfNeeded()
    self.layoutTableFooterView(footerView, edges: edges)
  }
  
  
  /// Automatic height for your footer. Call it on didLayoutSubviews
  ///
  /// - parameter footerView: Your custom header view
  /// - parameter edges:      Specify potential spacing insets
  public func layoutTableFooterView(_ footerView: UIView, edges: UIEdgeInsets? = nil) {
    var horizontalMargins: CGFloat = 0
    var verticalMargins: CGFloat = 0
    if let edges = edges {
      horizontalMargins = edges.left + edges.right
      verticalMargins = edges.top + edges.bottom
    }
    let height = footerView.systemLayoutSizeFitting(CGSize(width: self.base.frame.width - horizontalMargins,
                                                           height: CGFloat.greatestFiniteMagnitude)).height
    
    var frame = footerView.frame
    frame.size.height = height + verticalMargins
    footerView.frame = frame
    self.base.tableFooterView = footerView
  }
}
