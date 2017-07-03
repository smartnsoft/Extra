//
//  ButtonCell.swift
//  Extra
//
//  Created by Damien Chomat on 03/07/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

final class LabelCell: UITableViewCell {
  
  static var reuseIdentifier: String { return String(describing: self) }
  
  @IBOutlet weak var ibLabel: UILabel!
  
  
  func load(_ title: String) {
    self.ibLabel.text = title
  }
  
}
