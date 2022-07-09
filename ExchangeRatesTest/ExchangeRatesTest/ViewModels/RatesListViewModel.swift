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

	var alertMessage: String = ""

	func fetchRates() {

		OldNetworkManager.shared.getRequestForRates { [unowned self] (responseModel, massage) in

			guard let model = responseModel?.rates else { return }
			self.ratesModelArray = model
			self.rates.on(.next(model))
			alertMessage = massage ?? ""
		}
	}

	func didSelectRow(at indexPath: IndexPath) {
		coordinator?.onSelect(rates: ratesModelArray[indexPath.row])
	}

	func getInfo() {
		coordinator?.getInfo(message: alertMessage)
	}

}
