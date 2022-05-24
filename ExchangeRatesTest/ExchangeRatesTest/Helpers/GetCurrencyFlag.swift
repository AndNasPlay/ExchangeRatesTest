//
//  GetCurrencyFlag.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 24.05.2022.
//

import UIKit
import FlagKit

final class GetCurrencyFlag {

	private let flags = CurrencySymbols.shared.flagDictionary

	func getFlagImage(value: Int) -> UIImage {
		let bundle = FlagKit.assetBundle
		guard let name = flags[value] else {
			return UIImage(named: "CY", in: bundle, compatibleWith: nil)!
		}
		return UIImage(named: name, in: bundle, compatibleWith: nil)!
	}

}
