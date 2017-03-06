//
//  UIApplication+Extra.swift
//  Pods
//
//  Created by Jean-Charles SORIN on 08/11/2016.
//
//

public struct Extra<Base> {
  public let base: Base
  public init(_ base: Base) {
    self.base = base
  }
}

/**
 A type that has Extra extensions.
 */
public protocol ExtraCompatible {
  associatedtype CompatibleType
  static var ex: Extra<CompatibleType>.Type { get }
  var ex: Extra<CompatibleType> { get }
}

public extension ExtraCompatible {
  public static var ex: Extra<Self>.Type {
    return Extra<Self>.self
  }
  
  public var ex: Extra<Self> {
    return Extra(self)
  }
}
