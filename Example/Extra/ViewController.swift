//
//  ViewController.swift
//  Extra
//
//  Created by Jean-Charles SORIN on 11/07/2016.
//  Copyright (c) 2016 Jean-Charles SORIN. All rights reserved.
//

import UIKit
import Extra

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "Welcome on Extra ;)"
    // Do any additional setup after loading the view, typically from a nib.
    UIApplication.ex.hideActivityIndicator()
  }
  
}

extension ViewController: UITableViewDelegate {
  
}

extension ViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
}

