//
//  UIKitViewController.swift
//  Extra
//
//  Created by Damien Chomat on 03/07/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import Extra

enum ButtonKind: Int {
  case dashedBorder
  case shadowBorder
  case bottomDivider
  
  var text: String {
    var retValue: String
    switch self {
    case .dashedBorder:
      retValue = "Toogle a dashed border"
    case .shadowBorder:
      retValue = "Toggle a shadow border"
    case .bottomDivider:
      retValue = "Toggle a bottom divider"
    }
    return retValue
  }
  
  static var count: Int { return ButtonKind.bottomDivider.hashValue + 1 }
}

final class UIKitViewController: UIViewController {
  
  // MARK: Outlets
  @IBOutlet weak var ibExampleView: UIView!
  @IBOutlet weak var ibTableView: UITableView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.ibTableView.dataSource = self
    self.ibTableView.delegate = self
    let nib = UINib(nibName: LabelCell.reuseIdentifier, bundle: nil)
    self.ibTableView.register(nib, forCellReuseIdentifier: LabelCell.reuseIdentifier)
  }
  
}

extension UIKitViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let data = ButtonKind(rawValue: indexPath.row) else {
        return
    }
    self.didTapButton(with: data)
  }
  
  func didTapButton(with kind: ButtonKind) {
    let extraView = Extra<UIView>(self.ibExampleView)
    extraView.base.layer.sublayers = nil
    switch kind {
    case .dashedBorder:
      extraView.addDashedBorder()
    case .shadowBorder:
      extraView.addShadowBorder()
    case .bottomDivider:
      extraView.addBottomDivider(color: .white, alpha: 0.5, thickness: 10, widthMultiplier: 0.9)
    }
  }
  
}

extension UIKitViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return ButtonKind.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let data = ButtonKind(rawValue: indexPath.row),
      let cell = tableView.dequeueReusableCell(withIdentifier: LabelCell.reuseIdentifier, for: indexPath) as? LabelCell else {
        return UITableViewCell()
    }
    cell.load(data.text)
    
    return cell
  }
  
}
