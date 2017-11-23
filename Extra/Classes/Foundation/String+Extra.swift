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

extension String {
  
  /// Same as boundingRect(), but simplified !
  ///
  /// - parameter width:      width into the string is constrained
  /// - parameter attributes: Your attributed string attributes
  ///
  /// - returns: computed height according to the string length
  public func heightConstrained(to width: CGFloat, attributes: [NSAttributedStringKey: Any]? = nil) -> CGFloat {
    
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
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
  }
  
  /// Capitalize only the first letter of the entire string (localized capitalized)
  public func firstCapitalized() -> String {
    
    if self.isEmpty { return self }
    
    return String(self.prefix(1)).uppercased() + String(self.dropFirst())
  }
  
  /// Check if the string matches to the passed regex
  public func matchesRegex(regex: String) -> Bool {
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    return predicate.evaluate(with: self)
  }
  
  /// Base-64 encoded String from a raw String
  ///
  /// - Returns: encoded string
  func base64() -> String? {
    return self.data(using: String.Encoding.utf8)?.base64EncodedString()
  }
  
}
