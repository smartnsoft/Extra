//
//  UITests_UIKit.swift
//  Extra
//
//  Created by Damien Chomat on 03/07/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest

class UITests_UIKit: XCTestCase {
        
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
    
    func testUIBorders() {
      let tablesQuery = XCUIApplication().tables
      tablesQuery.staticTexts["UIKit Extensions"].tap()
      tablesQuery.staticTexts["Toogle a dashed border"].tap()
      tablesQuery.staticTexts["Toggle a bottom divider"].tap()
      tablesQuery.staticTexts["Toggle a shadow border"].tap()
    }
    
}
