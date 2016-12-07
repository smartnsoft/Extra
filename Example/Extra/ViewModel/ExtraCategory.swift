//
//  ExtraCategory.swift
//  Extra
//
//  Created by Jean-Charles SORIN on 07/12/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

protocol CategoryItem {
  var title: String { get set }
  var action: () -> () { get set }
}

struct ExtraCategory: CategoryItem {

  internal var title: String
  
  internal var action: () -> ()

}



struct ExtraSubCategory: CategoryItem {

  internal var title: String
  
  internal var action: () -> ()
  
}
