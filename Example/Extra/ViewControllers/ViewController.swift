//
//  ViewController.swift
//  Extra
//
//  Created by Jean-Charles SORIN on 11/07/2016.
//  Copyright (c) 2016 Smart&Soft. All rights reserved.
//

import UIKit
import Extra

class ViewController: UIViewController {
  
  fileprivate var categories = [ExtraCategory]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "Welcome on Extra ;)"

    let foundationCategory = ExtraCategory(title: "Foundation Extensions", action: {
      let controller = StoryboardScene.FoundationExamples.initialViewController()
      self.navigationController?.pushViewController(controller, animated: true)
    })
    
    let uikitCategory = ExtraCategory(title: "UIKit Extensions", action: {
      let controller = StoryboardScene.UIKitExamples.initialViewController()
      self.navigationController?.pushViewController(controller, animated: true)
    })
    
    let realmCategory = ExtraCategory(title: "Realm Extensions", action: {
      let controller = StoryboardScene.RealmExamples.initialViewController()
      self.navigationController?.pushViewController(controller, animated: true)
    })
    
    self.categories = [foundationCategory, uikitCategory, realmCategory]
    
  }
  
}


// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    let category = self.categories[indexPath.row]
    category.action()
  }
}


// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.categories.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
    
    let category = self.categories[indexPath.row]
    
    cell.textLabel?.text = category.title
    
    return cell
  }
}

