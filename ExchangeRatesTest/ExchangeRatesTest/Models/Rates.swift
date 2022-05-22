//
//  Rates.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 21.05.2022.
//

import Foundation

struct Rates: Decodable {
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

	enum CodingKeys: String, CodingKey {
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
}
