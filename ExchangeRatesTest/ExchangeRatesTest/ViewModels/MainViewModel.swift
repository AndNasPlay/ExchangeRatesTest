//
//  MainViewModel.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 22.05.2022.
//

import Foundation

final class MainViewModel {

	var coordinator: MainCoordinator?

	func getRates() {
		coordinator?.mainButtonTouchUpInside()
	}
}
