import XCTest

class TestSign: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        deleteAllData()
    }
    
    // No.01-1
    func testScreenFactor(){
        let canvasElement = app.otherElements["canvas"]
        canvasElement.swipeRight()
    }
    
    func deleteAllData() {
        let app = XCUIApplication()
        app.launchArguments = ["--Reset"]
        app.launch()
    }

}
