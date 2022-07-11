//
//  RatesListViewModel.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 21.05.2022.
//

import RxSwift
import UIKit

final class RatesListViewModel {

	let title = "Курсы валют"

	var coordinator: RatesListCoordinator?

	public let rates = BehaviorSubject(value: [Rates]())

	let getCurrencyFlag = GetCurrencyFlag()

	private var ratesModelArray: [Rates] = [Rates]()

	private let networkManager = NetworkManager.shared

	var alertMessage: String = ""

	func fetchRates() {

		networkManager.getCurrencies { [weak self] (currency, message, error) in
			guard let self = self else { return }
			guard let model = currency?.rates else { return }
			self.ratesModelArray = model
			self.rates.on(.next(model))
			if error == nil {
				self.alertMessage = message ?? ""
			} else {
				self.alertMessage = error ?? ""
			}
		}
	}

	func didSelectRow(at indexPath: IndexPath) {
		coordinator?.onSelect(rates: ratesModelArray[indexPath.row])
	}

	func getInfo() {
		coordinator?.getInfo(message: alertMessage)
	}

}
