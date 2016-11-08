//
//  UITableView+Extra.swift
//  Pods
//
//  Created by Jean-Charles SORIN on 08/11/2016.
//
//

import Foundation

extension UITableView {
  
  func ex_setAndLayoutTableHeaderView(_ headerView: UIView, edges: UIEdgeInsets? = nil) {
    self.tableHeaderView = headerView
    headerView.setNeedsLayout()
    headerView.layoutIfNeeded()
    ex_layoutTableHeaderView(headerView, edges: edges)
  }
  
  /**
   Automatic height for your header. Call it on didLayoutSubviews
   
   - parameter view: Header embeded view
   - parameter edges: edges of the embeded header
   */
  func ex_layoutTableHeaderView(_ headerView: UIView, edges: UIEdgeInsets? = nil) {
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
  
  func ex_setAndLayoutTableFooterView(_ footerView: UIView, edges: UIEdgeInsets? = nil) {
    self.tableFooterView = footerView
    footerView.setNeedsLayout()
    footerView.layoutIfNeeded()
    ex_layoutTableFooterView(footerView, edges: edges)
  }
  
  /**
   Automatic height for your header. Call it on didLayoutSubviews
   
   - parameter view: Header embeded view
   - parameter edges: edges of the embeded header
   */
  func ex_layoutTableFooterView(_ footerView: UIView, edges: UIEdgeInsets? = nil) {
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
