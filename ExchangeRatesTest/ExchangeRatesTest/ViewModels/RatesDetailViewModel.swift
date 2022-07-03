//
//  RatesDetailViewModel.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 22.05.2022.
//

import RxSwift
import UIKit

final class RatesDetailViewModel {

	private var rates: Rates?

	public let ratesSequence = BehaviorSubject(value: [String]())

	var coordinator: RatesDetailCoordinator?

	private let getCurrencyFlag = GetCurrencyFlag()

	init(rates: Rates) {
		self.rates = rates
	}

	func viewDidDisappear() {
		coordinator?.didFinish()
	}

	func getSequence() {
		guard rates != nil else { return }
		var sequence = [String]()
		sequence.append(rates?.name ?? "")
		sequence.append(rates?.buy ?? "")
		sequence.append(rates?.deltaBuy ?? "")
		sequence.append(rates?.sale ?? "")
		sequence.append(rates?.deltaSale ?? "")
		sequence.append(rates?.basic ?? "")
		sequence.append("\(rates?.fromValueNumber ?? 1)")
		ratesSequence.on(.next(sequence))
	}

	func configureView(view: RatesDetailView) {
		guard rates != nil else { return }
		view.toLable.text = rates?.currMnemTo
		view.fromLable.text = rates?.currMnemFrom

		let fromFlag = getCurrencyFlag.getFlagImage(value: rates?.fromCountry ?? 810)
		let toFlag = getCurrencyFlag.getFlagImage(value: rates?.toCountry ?? 810)

		view.fromImageView.image = fromFlag
		view.toImageView.image = toFlag
	}
}
