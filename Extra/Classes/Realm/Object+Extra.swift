//
//  Object+Extra.swift
//  Pods
//
//  Created by Jean-Charles SORIN on 09/11/2016.
//
//

import Foundation
import RealmSwift

extension Object {
  
  
  /// Simply write and add your update in Realm
  ///
  /// - parameter update:  Default is true if your object have a primary key
  /// - parameter inRealm: Specify a Realm if needed, otherwise the default Realm will be used
  ///
  /// - throws: Realm exception
  open func addWithUpdate(update: Bool = true, in inRealm: Realm? = nil) throws {
    var realm: Realm
    if let inRealm = inRealm {
      realm = inRealm
    } else {
      realm = try Realm()
    }
    
    try realm.write({ () -> Void in
      realm.add(self, update: update)
      try realm.commitWrite()
    })
  }
}
