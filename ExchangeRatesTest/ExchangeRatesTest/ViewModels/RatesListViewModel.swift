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
import FlagKit

final class RatesListViewModel {

	let title = "Курсы валют"

	var coordinator: RatesListCoordinator?

	public let rates = BehaviorSubject(value: [Rates]())

	private let flags = CurrencySymbols().flagDictionary

	private var ratesModelArray: [Rates] = [Rates]()

	func fetchRates() {

		NetworkManager.shared.getRequestForRates { [unowned self] (responseModel) in

			guard let model = responseModel else { return }
			self.ratesModelArray = model
			print(model)
			self.rates.on(.next(model))
		}
	}

	func didSelectRow(at indexPath: IndexPath) {
		coordinator?.onSelect(rates: ratesModelArray[indexPath.row])
	}

	func getCurrencySymbol(value: Int) -> UIImage {
		let bundle = FlagKit.assetBundle
		guard let name = flags[value] else {
			return UIImage(named: "CY", in: bundle, compatibleWith: nil)!
		}
		return UIImage(named: name, in: bundle, compatibleWith: nil)!
	}
}
