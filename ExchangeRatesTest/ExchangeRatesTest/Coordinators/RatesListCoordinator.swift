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

	let ratesListViewController = RatesListViewController()

	var parentCoordinator: MainCoordinator?

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	func start() {
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

	func getInfo(message: String) {
		let alertController = UIAlertController(title: "Information", message: message, preferredStyle: .alert)
		let action = UIAlertAction(title: "OK", style: .default, handler: nil)
		alertController.addAction(action)
		ratesListViewController.present(alertController, animated: true, completion: nil)
	}

	func childDidFinish(_ childCoordinator: Coordinator) {
		if let index = childCoordinators.firstIndex(where: { (coordinator) -> Bool in
			return childCoordinator === coordinator
		}) {
			childCoordinators.remove(at: index)
		}
	}
}
