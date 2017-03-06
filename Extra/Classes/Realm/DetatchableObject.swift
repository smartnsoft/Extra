//
//  DetatchableObject.swift
//  Pods
//
//  Created by Jean-Charles SORIN on 30/01/2017.
//
//

import Foundation
import RealmSwift

// MARK: Needed to fully detach a Realm object AND its relations out from realm
public protocol DetachableObject: AnyObject {
  
  func detached() -> Self
  
}

extension Object: DetachableObject {
  
  public func detached() -> Self {
    let detached = type(of: self).init()
    for property in objectSchema.properties {
      guard let value = value(forKey: property.name) else { continue }
      if let detachable = value as? DetachableObject {
        detached.setValue(detachable.detached(), forKey: property.name)
      } else {
        detached.setValue(value, forKey: property.name)
      }
    }
    return detached
  }
  
}

extension List: DetachableObject {
  
  public func detached() -> List<Element> {
    let result = List<Element>()
    forEach {
      result.append($0.detached())
    }
    return result
  }
  
}
