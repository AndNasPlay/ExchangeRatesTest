//
//  CurrencyModel.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 09.07.2022.
//

import Foundation

struct CurrencyData: Decodable {
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

struct Rate: Decodable {
	let fromCountry: Int
	let currMnemFrom: String
	let fromValueNumber: Int
	let sale: String
	let buy: String
	let deltaSale: String
	let basic: String
	let deltaBuy: String
	let currMnemTo: String
	let toCountry: Int
	let name: String

	init(
		fromCountry: Int, currMnemFrom: String, fromValueNumber: Int, sale: String, buy: String,
		deltaSale: String, basic: String, deltaBuy: String, currMnemTo: String, toCountry: Int,
		name: String) {

		self.fromCountry = fromCountry
		self.currMnemFrom = currMnemFrom
		self.fromValueNumber = fromValueNumber
		self.sale = sale
		self.buy = buy
		self.deltaSale = deltaSale
		self.basic = basic
		self.deltaBuy = deltaBuy
		self.currMnemTo = currMnemTo
		self.toCountry = toCountry
		self.name = name
	}

}

extension Rate {

	private enum CodingKeys: String, CodingKey {
		case fromCountry = "from"
		case currMnemFrom
		case fromValueNumber = "tp"
		case sale
		case buy
		case deltaSale
		case basic
		case deltaBuy
		case currMnemTo
		case toCountry = "to"
		case name
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		fromCountry = try container.decode(Int.self, forKey: .fromCountry)
		currMnemFrom = try container.decode(String.self, forKey: .currMnemFrom)
		fromValueNumber = try container.decode(Int.self, forKey: .fromValueNumber)
		sale = try container.decode(String.self, forKey: .sale)
		buy = try container.decode(String.self, forKey: .buy)
		deltaSale = try container.decode(String.self, forKey: .deltaSale)
		basic = try container.decode(String.self, forKey: .basic)
		deltaBuy = try container.decode(String.self, forKey: .deltaBuy)
		currMnemTo = try container.decode(String.self, forKey: .currMnemTo)
		toCountry = try container.decode(Int.self, forKey: .toCountry)
		name = try container.decode(String.self, forKey: .name)
	}

}
