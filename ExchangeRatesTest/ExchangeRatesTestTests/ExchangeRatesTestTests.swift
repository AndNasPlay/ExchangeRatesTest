//
//  ExchangeRatesTestTests.swift
//  ExchangeRatesTestTests
//
//  Created by Андрей Щекатунов on 21.05.2022.
//

import XCTest
@testable import ExchangeRatesTest

class ExchangeRatesTestTests: XCTestCase {

//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }

	func testGetData() throws {
		let getData = try XCTUnwrap(NetworkManager.shared)
		getData.getRequestForRates { response, message in
			switch response {
			case .some(let model):
				XCTAssertEqual(model.rates?.count ?? 0 > 0, true)
			case .none:
				XCTFail(message ?? "")
			}
		}
		waitForExpectations(timeout: 10)
	}

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
