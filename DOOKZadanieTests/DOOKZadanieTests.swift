import XCTest
@testable import DOOKZadanie

class DOOKZadanieTests: XCTestCase {
    var viewModel : CatListViewModel!
    var imageLoader: ImageLoaderService!
    
    
    override func setUp() {
        super.setUp()
        viewModel = CatListViewModel()
        imageLoader = ImageLoaderService()
    }
    
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    func test_API_Return_With_Good_API_Call() throws {
        viewModel.apiURL = "https://api.thecatapi.com/v1/images/search?limit=5"
        viewModel.getCatsData()
        print(viewModel.catsList)
        DispatchQueue.main.async {
            XCTAssertFalse(self.viewModel.catsList.isEmpty)
        }
    }
    
    
    func test_API_Return_With_Bad_API_Call() throws {
        viewModel.apiURL = ""
        viewModel.getCatsData()
        DispatchQueue.main.async {
            XCTAssertFalse(self.viewModel.catsList.isEmpty)
        }
    }
    
    
    func test_ImageLoader_With_Good_Call() throws {
        imageLoader.loadImage(urlString: "https://cdn2.thecatapi.com/images/32l.jpg", completionHandler: { completed in
            XCTAssertTrue(completed)
        })
    }
    
    
    func test_ImageLoader_With_Bad_Call() throws {
        imageLoader.loadImage(urlString: "", completionHandler: { completed in
            XCTAssertFalse(completed)
        })
    }
}
