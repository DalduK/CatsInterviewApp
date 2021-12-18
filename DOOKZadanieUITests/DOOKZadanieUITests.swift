import XCTest

class DOOKZadanieUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    
    func testIfPageIsRefreshing() throws {
        let app = XCUIApplication()
        app.launch()
        
        let refreshButton = app.buttons["refreshButton"]
        let catList = app.tables["List"]
        
        XCTAssertTrue(catList.cells.count > 0)
        
        let firstCell = catList.cells.element(boundBy: 0)
        let catImage = firstCell.images["CatImage"]
        //getting height of first image
        let firstH = catImage.frame.height
        
        XCTAssertTrue(catImage.waitForExistence(timeout: 3))
        
        refreshButton.tap()
        //sleep so that we are sure it tests different image
        sleep(1)
        XCTAssertTrue(catImage.waitForExistence(timeout: 3))
        //getting height of second image
        let secondH = catImage.frame.height
        //comparing to check if they are different
        XCTAssertFalse(firstH == secondH)
    }
    
    
    func testIfSheetWorksCorrectly() throws {
        let app = XCUIApplication()
        app.launch()
        
        let catList = app.tables["List"]
        
        XCTAssertTrue(catList.cells.count > 0)
        
        let firstCell = catList.cells.element(boundBy: 0)
        let catImage = firstCell.images["CatImage"]
        let modalImageOrProggress = app.images["ProgressOrImageSheet"]
        let closeModal = app.buttons["DismissModal"]
        
        XCTAssertTrue(catList.exists)
        //waiting for pics to load
        XCTAssertTrue(catImage.waitForExistence(timeout: 3))
        
        firstCell.tap()
        //checks if modal image is present
        XCTAssertTrue(modalImageOrProggress.exists)
        //dismiss modal
        closeModal.tap()
    }
}
