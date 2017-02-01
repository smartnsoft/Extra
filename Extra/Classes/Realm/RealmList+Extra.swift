//
//  RealmList+Extra.swift
//  Pods
//
//  Created by Jean-Charles SORIN on 02/02/2017.
//
//

import Foundation
import RealmSwift

public extension RealmSwift.List {
  
  
  /// Return lsit of object as a sequence
  ///
  /// - Returns: [Object]
  public func toArray() -> [T] {
    return self.map {$0}
  }
}
