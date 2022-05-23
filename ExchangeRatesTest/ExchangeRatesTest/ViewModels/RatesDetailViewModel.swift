//
//  RatesDetailViewModel.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 22.05.2022.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit
import FlagKit

class RatesDetailViewModel {

	private var rates: Rates?

	public let ratesSequence = BehaviorSubject(value: [String]())

	var coordinator: RatesDetailCoordinator?

	private let flags = CurrencySymbols.shared.flagDictionary

	init(rates: Rates) {
		self.rates = rates
	}

	func viewDidDisappear() {
		coordinator?.didFinish()
	}

	func getSequence() {
		guard rates != nil else { return }
		var sequence: [String] = [String]()
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

		let fromFlag = getCurrencyFlag(value: rates?.fromCountry ?? 810)
		let toFlag = getCurrencyFlag(value: rates?.toCountry ?? 810)

		view.fromImageView.image = fromFlag
		view.toImageView.image = toFlag
	}

	func getCurrencyFlag(value: Int) -> UIImage {
		let bundle = FlagKit.assetBundle
		guard let name = flags[value] else {
			return UIImage(named: "CY", in: bundle, compatibleWith: nil)!
		}
		return UIImage(named: name, in: bundle, compatibleWith: nil)!
	}

}
