//
//  RatesListViewModel.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 21.05.2022.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class RatesListViewModel {

	public let rates = BehaviorSubject(value: [Rates]())

	func fetchRates() {

		NetworkManager.shared.getRequest { [unowned self] (responseModel) in

			guard let model = responseModel else { return }
			self.rates.on(.next(model))
		}
	}

	func getCurrencySymbol(value: String) -> UIImage {
		switch value {
		case "EUR":
			return CurrencySymbols.EUR.image
		case "USD":
			return CurrencySymbols.USD.image
		case "JPY":
			return CurrencySymbols.JPY.image
		case "KZT":
			return CurrencySymbols.KZT.image
		case "CHF":
			return CurrencySymbols.CHF.image
		case "CNY":
			return CurrencySymbols.CNY.image
		case "BYN":
			return CurrencySymbols.BYN.image
		case "NOK":
			return CurrencySymbols.NOK.image
		case "TRY":
			return CurrencySymbols.TRY.image
		default:
			return UIImage(systemName: "centsign.circle")!
		}
	}
}
