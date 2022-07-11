//
//  RatesResults.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 21.05.2022.
//

import Foundation

struct RatesResults: Decodable {
	let productState: Int?
	let message: String
	let rid: String?
	let ratesDate: String?
	let messageTitle: String?
	let code: Int?
	let downloadDate: String?
	let rates: [Rates]?

	init(
		productState: Int, message: String, rid: String,
		ratesDate: String, messageTitle: String, code: Int,
		downloadDate: String, rates: [Rates] ) {

			self.productState = productState
			self.message = message
			self.rid = rid
			self.ratesDate = ratesDate
			self.messageTitle = messageTitle
			self.code = code
			self.downloadDate = downloadDate
			self.rates = rates
		}
}
