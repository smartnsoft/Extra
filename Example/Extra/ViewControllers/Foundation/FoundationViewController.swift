//
//  FoundationViewController.swift
//  Extra
//
//  Created by Jean-Charles SORIN on 09/12/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Extra

class FoundationViewController: UIViewController {
  
  @IBOutlet weak var ibValidFeedbackLabel: UILabel!
  @IBOutlet weak var ibMailTextField: UITextField!
  
  @IBOutlet weak var ibShuffleLabel: UILabel!
  @IBOutlet weak var ibLongTextLabel: UILabel!
  
  private var emojis = ["😀", "😬", "😁", "😂", "😃", "😄", "😅", "😆"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
   
    //Valid mail implementation
    self.ibMailTextField.addTarget(self, action: #selector(self.validateMail), for: .editingChanged)
    self.validateMail()
    
    //bounding rect on String
    let longText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    
    let height = longText.heightConstrained(to: self.ibLongTextLabel.frame.width,
                                            attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 17)])
    print("Your label will take an height of : \(height)")
    self.ibLongTextLabel.text = longText
    
    //Shuffle init
    self.updateSuffleLabel()
  }
  
  func validateMail() {
    if self.ibMailTextField.text?.isValidEmail() == true {
      ibValidFeedbackLabel.text = "Yep 😀"
    } else {
      ibValidFeedbackLabel.text = "Nope 🙃"
    }
  }
  
  private func updateSuffleLabel() {
    var text = ""
    self.emojis.forEach { (emoji) in
      text.append(emoji)
    }
    self.ibShuffleLabel.text = text
  }
  
  @IBAction func didTouchShuffleButton(_ sender: Any) {
    self.emojis.shuffle()
    self.updateSuffleLabel()
  }
  
}
