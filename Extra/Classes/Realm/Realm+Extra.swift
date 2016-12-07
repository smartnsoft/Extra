//
//  Realm+Extra.swift
//  Pods
//
//  Created by Jean-Charles SORIN on 09/11/2016.
//
//

import Foundation
import RealmSwift

extension Extra where Base: Realm {
  
  /// Return your [try Realm] instance no-throwable at any time
  ///
  /// - returns: Realm safe instance
  public static func safeInstance() -> Realm {
    do {
      return try Realm()
    } catch {
      fatalError("\(error)")
    }
  }
  
  
  /// Return your [try Realm] instance no-throwable at any time
  ///
  /// - Parameter config: Your specific Realm configuration to retrieve
  /// - Returns: Realm safe instance
  public static func safeInstane(config: Realm.Configuration) -> Realm {
    do {
      return try Realm(configuration: config)
    } catch {
      fatalError("\(error)")
    }
  }
}
