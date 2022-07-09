//
//  MainViewModel.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 22.05.2022.
//

import Foundation

final class MainViewModel {

	var coordinator: MainScreenCoordinator?

	func getRates() {
		coordinator?.mainButtonTouchUpInside()
	}
}
