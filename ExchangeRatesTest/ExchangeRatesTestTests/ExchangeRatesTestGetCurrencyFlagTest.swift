//
//  ExchangeRatesTestGetCurrencyFlagTest.swift
//  ExchangeRatesTestTests
//
//  Created by Андрей Щекатунов on 24.05.2022.
//

import XCTest
import FlagKit
@testable import ExchangeRatesTest

class ExchangeRatesTestGetCurrencyFlagTest: XCTestCase {

	func testGetCurrencyFlag() throws {
		let flagFinder = try XCTUnwrap(GetCurrencyFlag())
		let bundle = FlagKit.assetBundle
		let testFlag = 810
		let wrongTestFlag = 1249
		XCTAssert(flagFinder.getFlagImage(value: testFlag) == UIImage(named: "RU", in: bundle, compatibleWith: nil))
		XCTAssertTrue(flagFinder.getFlagImage(value: wrongTestFlag) == UIImage(named: "CY", in: bundle, compatibleWith: nil))
	}

}
