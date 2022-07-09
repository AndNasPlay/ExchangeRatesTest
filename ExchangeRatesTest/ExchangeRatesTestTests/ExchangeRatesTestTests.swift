//
//  ExchangeRatesTestTests.swift
//  ExchangeRatesTestTests
//
//  Created by Андрей Щекатунов on 21.05.2022.
//

import XCTest
@testable import ExchangeRatesTest

class ExchangeRatesTestGetDataTest: XCTestCase {

	func testGetData() throws {
		let getData = try XCTUnwrap(OldNetworkManager.shared)
		getData.getRequestForRates { response, message in
			switch response {
			case .some(let model):
				XCTAssertEqual(model.rates?.count ?? 0 > 0, true)
			case .none:
				XCTFail(message ?? "")
			}
		}
	}
}
