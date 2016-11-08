//
//  UICollectionViewCell+Extra.swift
//  Pods
//
//  Created by Jean-Charles SORIN on 08/11/2016.
//
//

extension UICollectionViewCell {
  open var collectionView: UICollectionView? {
    var view: UIView? = self.superview
    repeat {
      if let collectionView = view as? UICollectionView {
        return collectionView
      }
      view = view?.superview
    } while (view != nil)
    return nil
  }
}
