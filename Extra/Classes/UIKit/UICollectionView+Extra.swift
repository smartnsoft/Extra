//
//  UICollectionView+Extra.swift
//  Pods
//
//  Created by Jean-Charles SORIN on 07/11/2016.
//
//

import Foundation

extension UICollectionView {
  
  
  /// Check the index path pointer by the center point
  /// Usefull when you want to constently check the user scrolling and change a page indicator
  ///
  /// - returns: founded indexPath
  open func ex_currentIndexPathForCenter() -> IndexPath? {
    
    let point = CGPoint(x: self.frame.width / 2 + self.contentOffset.x,
                        y: self.frame.height / 2 + self.contentOffset.y)
    
    let indexPath = self.indexPathForItem(at: point)
    
    return indexPath
  }
  
  
  /// Correctly center the given cell at index paths to optimize the **vertical** center display.
  /// Use it for "expandable cells", if a cell is inserted into your collection view and there is no space to display it entirely, use this method.
  ///
  /// - parameter to:          The cell, under your according cell, that you want to display entirely
  /// - parameter accordingTo: The cell at the vertical top of your layout
  /// - parameter animated:    False by default
  open func ex_scrollVertically(to: IndexPath, accordingTo: IndexPath, animated: Bool = false) {
    if let dataSource = self.dataSource {
      let topCell = dataSource.collectionView(self, cellForItemAt: accordingTo)
      let bottomCell = dataSource.collectionView(self, cellForItemAt: to)
      let diff = (bottomCell.frame.origin.y + bottomCell.frame.size.height) - (self.contentOffset.y + self.frame.size.height)
      
      if diff > 0 {
        if diff < (topCell.frame.origin.y - self.contentOffset.y) {
          DispatchQueue.main.async {
            self.setContentOffset(CGPoint(x: 0, y: self.contentOffset.y + diff),
                                  animated: animated)
          }
        } else {
          DispatchQueue.main.async {
            self.setContentOffset(CGPoint(x: 0, y: self.contentOffset.y + (topCell.frame.origin.y - self.contentOffset.y)),
                                  animated: animated)
          }
        }
      }
    }
  }
}
