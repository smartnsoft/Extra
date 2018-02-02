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

extension MutableCollection {
  
  /// Shuffles the contents of this collection.
  public mutating func shuffle() {
    let c = count
    guard c > 1 else { return }
    
    for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
      let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
      guard d != 0 else { continue }
      let i = index(firstUnshuffled, offsetBy: d)
      self.swapAt(firstUnshuffled, i)
    }
  }
}

extension Sequence {
  
  /// Returns an array with the contents of this sequence, shuffled.
  ///
  /// - Returns: Array's copy shuffled
  public func shuffled() -> [Iterator.Element] {
    var result = Array(self)
    result.shuffle()
    return result
  }
  
}

extension Sequence where Element : Equatable {

  /// Returns an array with the content of this sequence after removing all duplicated elements.
  ///
  /// - Returns: Array's copy without duplicates
  public func withoutDuplicates() -> [Iterator.Element] {
    return self.reduce([]) { (result, element) in
      (result.contains(element)) ? result : result + [element]
    }
  }
  
}
