import UIKit
import XCTest
import Extra

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEmail() {
      let sampleStrings = ["", "@", ".cd", "a@.cd", "@b.cd", "a", "a@", "a@b", "a@b.", "b.cd", "a@b.c"]
      sampleStrings.forEach { (string) in
        let result = string.isValidEmail()
        debugPrint("\(result)")
        XCTAssert(result == false, "\(string) should not be a valid email")
      }
    }
  
  func testCapitalized() {
    let sampleString = "lowercased text"
    
    let result = sampleString.firstCapitalized()
    let components = result.components(separatedBy: " ")
    guard let first = components.first, let last = components.last else {
      assertionFailure("text parts not found")
      return
    }
    assert(first == "Lowercased" && last == "text", "firstCapitalized() returned: \(result) on: \(sampleString)")
  }

    
}
