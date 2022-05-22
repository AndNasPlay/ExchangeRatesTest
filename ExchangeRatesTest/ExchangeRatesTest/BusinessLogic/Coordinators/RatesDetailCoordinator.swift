//
//  RatesDetailCoordinator.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 22.05.2022.
//

import UIKit

final class RatesDetailCoordinator: Coordinator {

	private(set) var childCoordinators: [Coordinator] = []

	private let rates: Rates

	private let navigationController: UINavigationController

	var parentCoordinator: RatesListCoordinator?

	init(navigationController: UINavigationController, rates: Rates) {
		self.navigationController = navigationController
		self.rates = rates
	}

	func start() {
		let ratesDetailViewController: RatesDetailViewController = RatesDetailViewController()
		let ratesDetailViewModel = RatesDetailViewModel(rates: rates)
		ratesDetailViewModel.coordinator = self
		ratesDetailViewController.viewModel = ratesDetailViewModel
		navigationController.setViewControllers([ratesDetailViewController], animated: false)
	}

	func childDidFinish(_ childCoordinator: Coordinator) {
		if let index = childCoordinators.firstIndex(where: { (coordinator) -> Bool in
			return childCoordinator === coordinator
		}) {
			childCoordinators.remove(at: index)
		}
	}
}
