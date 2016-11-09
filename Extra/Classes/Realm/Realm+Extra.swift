//
//  Realm+Extra.swift
//  Pods
//
//  Created by Jean-Charles SORIN on 09/11/2016.
//
//

import Foundation

extension Realm {
  
  /// Return your [try Realm] instance no-throwable at any time
  ///
  /// - returns: Realm instance
  open static func safeInstance() -> Realm {
    do {
      return try Realm()
    } catch {
      fatalError("\(error)")
    }
  }
}
