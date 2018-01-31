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
import RealmSwift

/// This protocol defines an object which can delete these relations by itself.
/// Extend this protocol allows object to use delete and deleteAll extra methods.
public protocol ObjectRelationDeletable {
  
  /// Deletes relathionships of the model
  ///
  /// - Parameter realm: Specify a Realm context if needed, otherwise the default Realm will be used
  ///
  /// - throws: Realm exception
  func deleteRelationships(_ realm: Realm) throws

}

/// Default implementation of the ObjectRelationDeletable protocol
extension ObjectRelationDeletable {
  func deleteRelationships(_ realm: Realm) throws {}
}

extension Extra where Base: Object {
  
  // MARK: Queries
  
  /// Finds the first object of a specific type
  ///
  /// - parameter context: Specify a Realm context if needed, otherwise the default Realm will be used
  /// - parameter type: Type of the object to find
  ///
  /// - throws: Realm exception
  public static func findFirst<T>(in context: Realm? = nil, object type: T.Type = T.self) -> T? where T: Object {
    let realm = context ?? Realm.ex.safeInstance()
    return realm.objects(type).first
  }
  
  /// Finds all objects of the corresponding type
  ///
  /// - parameter context: Specify a Realm context if needed, otherwise the default Realm will be used
  /// - parameter type: Type of the objects to find
  ///
  /// - throws: Realm exception
  public static func findAll<T>(in context: Realm? = nil, object type: T.Type = T.self) -> Results<T> where T: Object {
    let realm = context ?? Realm.ex.safeInstance()
    return realm.objects(type)
  }
  
  // MARK: Writes
  
  /// Simply writes and adds or update your object in Realm
  ///
  /// - parameter update:  Default is true if your object have a primary key
  /// - parameter context: Specify a Realm context if needed, otherwise the default Realm will be used
  ///
  /// - throws: Realm exception
  public func add(in context: Realm? = nil, update: Bool = true) throws {
    let realm = context ?? Realm.ex.safeInstance()
    try realm.write({ () -> Void in
      realm.add(self.base, update: update)
      try realm.commitWrite()
    })
  }
  
  /// Adds or updates an object in realm
  ///
  /// - Parameters:
  ///   - object: The object to add or update
  ///   - context: Specify a Realm context if needed, otherwise the default Realm will be used
  ///
  /// - Throws: Realm exception
  public static func update<T>(object: T, in context: Realm? = nil) throws where T: Object {
    let realm = context ?? Realm.ex.safeInstance()
    try realm.write {
      realm.add(object, update: true)
    }
  }
  
  /// Adds or updates many objects in realm
  ///
  /// - Parameters:
  ///   - objects: The list of objects to add or update
  ///   - context: Specify a Realm context if needed, otherwise the default Realm will be used
  ///
  /// - Throws: Realm exception
  public static func update<T>(objects: [T], in context: Realm? = nil) throws where T: Object {
    let realm = context ?? Realm.ex.safeInstance()
    try realm.write {
      realm.add(objects, update: true)
    }
  }
  
  // MARK: Delete
  
  /// Delete an object from realm
  ///
  /// - Parameters:
  ///   - object: The object to delete
  ///   - context: Specify a Realm context if needed, otherwise the default Realm will be used
  ///
  /// - Throws: Realm exception
  public static func delete<T>(object: T?, from context: Realm? = nil) throws where T: Object & ObjectRelationDeletable {
    let realm = context ?? Realm.ex.safeInstance()
    if let object = object {
      try object.deleteRelationships(realm)
      try realm.write {
        realm.delete(object)
      }
    }
  }

  /// Delete many objects from realm
  ///
  /// - Parameters:
  ///   - object: The list of objects to delete
  ///   - context: Specify a Realm context if needed, otherwise the default Realm will be used
  ///
  /// - Throws: Realm exception
  public static func delete<T>(objects: List<T>?, from context: Realm? = nil) throws where T: Object & ObjectRelationDeletable {
    let realm = context ?? Realm.ex.safeInstance()
    if let objects = objects {
      try objects.forEach({ object in
        try object.deleteRelationships(realm)
      })
      try realm.write {
        realm.delete(objects)
      }
    }
  }

  /// Delete all objects of a specific type from realm
  ///
  /// - Parameters:
  ///   - context: Specify a Realm context if needed, otherwise the default Realm will be used
  /// - parameter type: Type of the objects to delete
  ///
  /// - Throws: Realm exception
  public static func deleteAll<T>(from context: Realm? = nil, object type: T.Type = T.self) throws where T: Object & ObjectRelationDeletable {
    let realm = context ?? Realm.ex.safeInstance()
    let objects: Results<T> = type.ex.findAll(in: realm)
    try objects.forEach { object in
      try type.ex.delete(object: object, from: realm)
    }
  }
  
}
