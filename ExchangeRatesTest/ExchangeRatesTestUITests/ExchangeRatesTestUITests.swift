//
//  ExchangeRatesTestUITests.swift
//  ExchangeRatesTestUITests
//
//  Created by Андрей Щекатунов on 21.05.2022.
//

import XCTest

class ExchangeRatesTestUITests: XCTestCase {

	func testTapMainButton() throws {
		let app = XCUIApplication()
		app.launch()
		let button = app.buttons["mainButton"].firstMatch
		XCTAssertTrue(button.isHittable)
		button.tap()
	}

	func testLaunchPerformance() throws {
		if #available(iOS 13.0, *) {
			measure(metrics: [XCTApplicationLaunchMetric()]) {
				XCUIApplication().launch()
			}
		}
	}

}
