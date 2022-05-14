import XCTest
import RxSwift
@testable import Commerce

class MockNetworkProviderTests: XCTestCase {
    let mockSession: URLSessionProtocol! = MockURLSession()
    var sut: NetworkProvider!
    var disposeBag: DisposeBag!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = NetworkProvider(session: mockSession)
        disposeBag = DisposeBag()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
        disposeBag = nil
    }

    func test_getHealthChecker가_정상작동_하는지() {
        let observableData = sut.request(api: HealthCheckerAPI())
        _ = observableData.subscribe(onNext: { data in
                let resultString = String(data: data, encoding: .utf8)
                let successString = #""OK""#
                XCTAssertEqual(resultString, successString)
        })
        .disposed(by: disposeBag)
    }
    
    func test_getHealthChecker가_정상실패_하는지() {
        sut = NetworkProvider(session: MockURLSession(isRequestSuccess: false))

        let observableData = sut.request(api: HealthCheckerAPI())
        _ = observableData.subscribe(onError: { error in
            let statusCodeError = NetworkError.statusCodeError
            XCTAssertEqual(error as? NetworkError, statusCodeError)
        })
        .disposed(by: disposeBag)
    }
}
