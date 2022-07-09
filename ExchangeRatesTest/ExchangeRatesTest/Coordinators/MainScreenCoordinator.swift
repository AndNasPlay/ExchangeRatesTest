//
//  MainScreenCoordinator.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 22.05.2022.
//

import UIKit

final class MainScreenCoordinator: Coordinator {

	private(set) var childCoordinators: [Coordinator] = []

	let networkManager = NetworkManager()

	private let navigationController: UINavigationController

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	func start() {
		let mainViewController: MainViewController = MainViewController()
		let mainViewModel = MainViewModel()
		mainViewModel.coordinator = self
		mainViewController.viewModel = mainViewModel
		navigationController.setViewControllers([mainViewController], animated: false)
	}

	func mainButtonTouchUpInside() {
		let ratesListCoordinator = RatesListCoordinator(navigationController: navigationController)
		ratesListCoordinator.parentCoordinator = self
		childCoordinators.append(ratesListCoordinator)
		ratesListCoordinator.start()

		networkManager.getCurrencies { (currencies, error) in
			DispatchQueue.main.async {
				print(currencies?.message)
				print(error)
			}
		}
	}

	func childDidFinish(_ childCoordinator: Coordinator) { }
}
