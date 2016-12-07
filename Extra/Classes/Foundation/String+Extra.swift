//
//  String+Extra.swift
//  Pods
//
//  Created by Jean-Charles SORIN on 09/11/2016.
//
//

import Foundation

extension String {
  
  /// Same as boundingRect(), but simplified !
  ///
  /// - parameter width:      width into the string is constrained
  /// - parameter attributes: Your attributed string attributes
  ///
  /// - returns: computed height according to the string length
  public func heightConstrained(to width: CGFloat, attributes: [String : Any]? = nil) -> CGFloat {
    
    let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
    
    let boundingBox = self.boundingRect(with: constraintRect,
                                        options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                        attributes: attributes,
                                        context: nil)
    
    return boundingBox.height
  }
  
  /// regex : [A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}
  ///
  /// - returns: True or false mail validation
  public func isValidEmail() -> Bool {
    
    guard self.isEmpty == false else {
      return false
    }
    do {
      let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}",
                                          options: .caseInsensitive)
      return regex.firstMatch(in: self,
                              options: NSRegularExpression.MatchingOptions(rawValue: 0),
                              range: NSRange(location: 0, length: self.characters.count)) != nil
    } catch {
      return false
    }
  }
  
  
  /// Capitalize only the first letter of the entire string (localized capitalized)
  public func firstCapitalized() -> String {
    
    if self.isEmpty { return self }
    var result = self
    result = result.substring(to: result.startIndex).localizedCapitalized
    if self.characters.count > 1 {
      result += result.substring(from: result.index(after: result.startIndex))
    }
    
    return result
  }
  
  /// Check if the string matches to the passed regex
  public func matchesRegex(regex: String) -> Bool {
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    return predicate.evaluate(with: self)
  }
  
}
