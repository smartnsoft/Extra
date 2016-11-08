//
//  UICollectionView+Extra.swift
//  Pods
//
//  Created by Jean-Charles SORIN on 07/11/2016.
//
//

import Foundation

extension UICollectionView {
  open func ex_currentIndexPathForCenter() -> IndexPath? {
    
    let point = CGPoint(x: self.frame.width / 2 + self.contentOffset.x,
                        y: self.frame.height / 2 + self.contentOffset.y)
    
    let indexPath = self.indexPathForItem(at: point)
    
    return indexPath
  }
  
  //Scroll to correct index, according to dependant index, if the destination cell is to large, no hide the according cell
  open func ex_scrollVertically(to: IndexPath, accordingTo: IndexPath, animated: Bool = false) {
    if let dataSource = self.dataSource {
      let topCell = dataSource.collectionView(self, cellForItemAt: accordingTo)
      let bottomCell = dataSource.collectionView(self, cellForItemAt: to)
      let diff = (bottomCell.frame.origin.y + bottomCell.frame.size.height) - (self.contentOffset.y + self.frame.size.height)
      
      if diff > 0 {
        if (diff < (topCell.frame.origin.y - self.contentOffset.y)) {
          DispatchQueue.main.async {
            self.setContentOffset(CGPoint(x: 0, y: self.contentOffset.y + diff),
                                  animated: animated)
          }
        }else {
          DispatchQueue.main.async {
            self.setContentOffset(CGPoint(x: 0, y: self.contentOffset.y + (topCell.frame.origin.y - self.contentOffset.y)),
                                  animated: animated)
          }
        }
      }
    }
  }
}
