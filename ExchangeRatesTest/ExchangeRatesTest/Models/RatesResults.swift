//
//  RatesResults.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 21.05.2022.
//

import Foundation

struct RatesResults: Decodable {
	let productState: Int?
	let message: String?
	let rid: String?
	let ratesDate: String?
	let messageTitle: String?
	let code: Int?
	let downloadDate: String?
	let rates: [Rates]?

	enum CodingKeys: String, CodingKey {
		case productState
		case message
		case rid
		case ratesDate
		case messageTitle
		case code
		case downloadDate
		case rates
	}
}
