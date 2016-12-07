//
//  UICollectionViewCell+Extra.swift
//  Pods
//
//  Created by Jean-Charles SORIN on 08/11/2016.
//
//

extension Extra where Base: UICollectionViewCell {
  
  
  /// The current collection view linked to your cell
  public var collectionView: UICollectionView? {
    var view: UIView? = self.base.superview
    repeat {
      if let collectionView = view as? UICollectionView {
        return collectionView
      }
      view = view?.superview
    } while (view != nil)
    return nil
  }
}
