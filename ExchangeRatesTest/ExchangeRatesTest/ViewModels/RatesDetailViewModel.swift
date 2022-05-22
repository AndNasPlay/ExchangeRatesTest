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

class RatesDetailViewModel {

	private var rates: Rates?

	var coordinator: RatesDetailCoordinator?

	init(rates: Rates) {
		self.rates = rates
	}
}
