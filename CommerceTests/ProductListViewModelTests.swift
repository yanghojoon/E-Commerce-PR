import XCTest
import RxSwift
@testable import Commerce

class ProductListViewModelTests: XCTestCase {
    var sut: ProductListViewModel!
    
    override func setUpWithError() throws {
        func mockAction(_ input: Int) { }
        sut = ProductListViewModel(actions: ProductListViewModelAction(showProductDetail: mockAction))
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_fetchProducts가_정상작동하는지() {
        let expectation = XCTestExpectation(description: "Request 비동기 테스트")
        _ = sut.test_fetchProducts()
            .subscribe(onNext: { productPage in
                XCTAssertEqual(productPage.itemsPerPage, 20)
                XCTAssertEqual(productPage.pageNumber, 1)
                expectation.fulfill()
            })
        
        wait(for: [expectation], timeout: 10.0)
    }
}
