//
//  UITableViewCell+Extra.swift
//  Pods
//
//  Created by Jean-Charles SORIN on 08/11/2016.
//
//

import Foundation

extension Extra where Base: UITableViewCell {
  
  /// The current table view linked to your cell
  public var tableView: UITableView? {
    var view: UIView? = self.base.superview
    repeat {
      if let tableView = view as? UITableView {
        return tableView
      }
      view = view?.superview
    } while (view != nil)
    return nil
  }
}
