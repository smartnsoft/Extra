//
//  UICollectionView+Extra.swift
//  Pods
//
//  Created by Jean-Charles SORIN on 07/11/2016.
//
//

import Foundation

extension UICollectionView {
  open func currentIndexPathForCenter() -> IndexPath? {
    
    let point = CGPoint(x: self.frame.width / 2 + self.contentOffset.x,
                        y: self.frame.height / 2 + self.contentOffset.y)
    
    let indexPath = self.indexPathForItem(at: point)
    
    return indexPath
  }
}
