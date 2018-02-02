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
    
    let computedSize = CGSize(width: self.base.frame.width - horizontalMargins,
                              height: CGFloat.greatestFiniteMagnitude)
    let height = headerView.systemLayoutSizeFitting(computedSize).height
    
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
    let computedSize = CGSize(width: self.base.frame.width - horizontalMargins,
                              height: CGFloat.greatestFiniteMagnitude)
    let height = footerView.systemLayoutSizeFitting(computedSize).height
    
    var frame = footerView.frame
    frame.size.height = height + verticalMargins
    footerView.frame = frame
    self.base.tableFooterView = footerView
  }
  
  /// Scrolls the tableView to the top (including its headerView).
  ///
  /// - Parameter animated: Scroll shoud be animated
  public func scrollToTop(animated: Bool) {
    self.base.setContentOffset(CGPoint(x: 0.0, y: -self.base.contentInset.top),
                               animated: animated)
  }
  
}
