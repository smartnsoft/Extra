//
//  UITests.swift
//  UITests
//
//  Created by Damien Chomat on 03/07/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest

class UITests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    XCUIApplication().launch()
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testShuffle() {
    let app = XCUIApplication()
    app.tables.staticTexts["Foundation Extensions"].tap()
    
    let shuffleMeButton = app.buttons["<- Shuffle me !"]
    shuffleMeButton.tap()
  }
  
  func testEmailCheck() {
    XCUIApplication().tables.staticTexts["Foundation Extensions"].tap()
    
    let textField = XCUIApplication().otherElements.containing(.navigationBar, identifier:"Welcome on Extra ;)").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element
    textField.tap()
    textField.typeText("d@d.dd")
    
  }
  
}
