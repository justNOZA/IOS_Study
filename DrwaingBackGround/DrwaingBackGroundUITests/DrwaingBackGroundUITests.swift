import XCTest

class TestSign: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
    }
    
    // No.01-1
    func testScreenFactor(){
        let canvasElement = app.otherElements["canvas"]
        canvasElement.swipeRight()
    }

}
