//
//  UITableViewCell+Extra.swift
//  Pods
//
//  Created by Jean-Charles SORIN on 08/11/2016.
//
//

import Foundation

extension UITableViewCell {
  
  open var ex_tableView:UITableView? {
    var view:UIView? = self.superview
    repeat {
      if let tableView = view as? UITableView {
        return tableView
      }
      view = view?.superview
    } while (view != nil)
    return nil
  }
}
