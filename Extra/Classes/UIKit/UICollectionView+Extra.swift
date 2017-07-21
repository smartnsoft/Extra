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

extension Extra where Base: UICollectionView {
  
  /// Check the index path pointer by the center point
  /// Useful when you want to constently check the user scrolling and change a page indicator
  ///
  /// - returns: founded indexPath
  public func currentIndexPathForCenter() -> IndexPath? {
    
    let point = CGPoint(x: self.base.frame.width / 2 + self.base.contentOffset.x,
                        y: self.base.frame.height / 2 + self.base.contentOffset.y)
    
    let indexPath = self.base.indexPathForItem(at: point)
    
    return indexPath
  }
  
  /// Correctly center the given cell at index paths to optimize the **vertical** center display.
  /// Use it for "expandable cells", if a cell is inserted into your collection view and there is no space to display it entirely, use this method.
  ///
  /// - parameter to:          The cell, under your according cell, that you want to display entirely
  /// - parameter accordingTo: The cell at the vertical top of your layout
  /// - parameter animated:    False by default
  public func scrollVertically(to: IndexPath, accordingTo: IndexPath, animated: Bool = false) {
    
    if let dataSource = self.base.dataSource {
      let topCell = dataSource.collectionView(self.base, cellForItemAt: accordingTo)
      let bottomCell = dataSource.collectionView(self.base, cellForItemAt: to)
      let diff = (bottomCell.frame.origin.y + bottomCell.frame.size.height) - (self.base.contentOffset.y + self.base.frame.size.height)
      
      if diff > 0 {
        if diff < (topCell.frame.origin.y - self.base.contentOffset.y) {
          DispatchQueue.main.async {
            let offsetPoint = CGPoint(x: 0, y: self.base.contentOffset.y + diff)
            self.base.setContentOffset(offsetPoint,
                                       animated: animated)
          }
        } else {
          DispatchQueue.main.async {
            let offsetPoint = CGPoint(x: 0, y: self.base.contentOffset.y + (topCell.frame.origin.y - self.base.contentOffset.y))
            self.base.setContentOffset(offsetPoint,
                                       animated: animated)
          }
        }
      }
    }
  }
}
