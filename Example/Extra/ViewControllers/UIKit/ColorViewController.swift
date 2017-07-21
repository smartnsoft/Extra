//
//  ColorViewController.swift
//  Extra
//
//  Created by Damien Chomat on 06/07/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

final class ColorViewController: UIViewController {
  
  var color: UIColor = UIColor.black
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = self.color
  }
}
