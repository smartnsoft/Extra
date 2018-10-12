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
  case switchChild
  
  var text: String {
    var retValue: String
    switch self {
    case .dashedBorder:
      retValue = "Toggle a dashed border"
    case .shadowBorder:
      retValue = "Toggle a shadow border"
    case .bottomDivider:
      retValue = "Toggle a bottom divider"
    case .switchChild:
      retValue = "Switch child"
    }
    return retValue
  }
  
  static var count: Int { return ButtonKind.switchChild.hashValue + 1 }
}

final class UIKitViewController: UIViewController {
  
  // MARK: Outlets
  @IBOutlet weak var ibExampleView: UIView!
  @IBOutlet weak var ibTableView: UITableView!
  @IBOutlet weak var ibCustomButton: UIButton!
  
  var switchLocked = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.ibTableView.dataSource = self
    self.ibTableView.delegate = self
    let nib = UINib(nibName: LabelCell.reuseIdentifier, bundle: nil)
    self.ibTableView.register(nib, forCellReuseIdentifier: LabelCell.reuseIdentifier)
    
    self.ibCustomButton.ex.configure(withTitle: "button",
                                     titleFont: UIFont.systemFont(ofSize: 16),
                                     titleColor: .black,
                                     backgroundColor: .orange,
                                     cornerRadius: 5.0)
    
    let newVc = ColorViewController()
    newVc.color = self.children.last?.view.backgroundColor == .orange ? .blue : .orange
    //self.ex.addChildViewController(newVc, in: self.ibExampleView, insets: .zero)
    self.ex.switchChilds(from: nil, to: newVc, in: self.ibExampleView, duration: 1)
  }
}

extension UIKitViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let data = ButtonKind(rawValue: indexPath.row) else {
      return
    }
    didTapButton(with: data)
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func didTapButton(with kind: ButtonKind) {
    switch kind {
    case .dashedBorder:
      resetView()
      self.ibExampleView.ex.addDashedBorder()
    case .shadowBorder:
      resetView()
      self.ibExampleView.ex.addShadowBorder()
    case .bottomDivider:
      resetView()
      self.ibExampleView.ex.addBottomDivider(color: .white, alpha: 0.5, thickness: 10, widthMultiplier: 0.9)
    case .switchChild:
      if !switchLocked {
        let currentVc = self.children.last
        let newVc = ColorViewController()
        newVc.color = currentVc?.view.backgroundColor == .orange ? .blue : .orange
        self.ex.switchChilds(from: currentVc,
                             to: newVc,
                             in: self.ibExampleView,
                             duration: 1,
                             transitionOptions: .transitionFlipFromLeft,
                             completion: { (finished) in
                              if finished {
                                self.switchLocked = false
                              }
        })
      }
    }
  }
  
  func resetView() {
    let layer = self.ibExampleView.layer
    layer.sublayers?.removeAll()
    layer.shadowPath = nil
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
