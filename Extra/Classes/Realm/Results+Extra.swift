//
//  Realm+Extra.swift
//  Pods
//
//  Created by Jean-Charles SORIN on 09/11/2016.
//
//

import Foundation
import RealmSwift

public extension Results {
  
  /// Safety getter object on your results
  ///
  /// - parameter index: The desired index
  ///
  /// - returns: Your Realm result object at the correct index, nil if out of bound
  public subscript (safe index: Int) -> T? {
    return index < count && index >= 0 ? self[index] : nil
  }
  
  /// Return results as a sequence
  /// Temporary name
  /// - Returns: [Object]
  public func ex_toArray() -> [T] {
    return Array(self)
  }
  
}
