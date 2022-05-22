//
//  RatesListCoordinator.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 22.05.2022.
//

import UIKit

final class RatesListCoordinator: Coordinator {

	private(set) var childCoordinators: [Coordinator] = []

	private let navigationController: UINavigationController

	var parentCoordinator: MainCoordinator?

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	func start() {
		let ratesListViewController: RatesListViewController = RatesListViewController()
		let ratesListViewModel = RatesListViewModel()
		ratesListViewModel.coordinator = self
		ratesListViewController.viewModel = ratesListViewModel
		navigationController.setViewControllers([ratesListViewController], animated: false)
	}

	func onSelect(rates: Rates) {
		let ratesDetailCoordinator = RatesDetailCoordinator(navigationController: navigationController, rates: rates)
		ratesDetailCoordinator.parentCoordinator = self
		childCoordinators.append(ratesDetailCoordinator)
		ratesDetailCoordinator.start()
	}

	func childDidFinish(_ childCoordinator: Coordinator) {
		if let index = childCoordinators.firstIndex(where: { (coordinator) -> Bool in
			return childCoordinator === coordinator
		}) {
			childCoordinators.remove(at: index)
		}
	}
}
