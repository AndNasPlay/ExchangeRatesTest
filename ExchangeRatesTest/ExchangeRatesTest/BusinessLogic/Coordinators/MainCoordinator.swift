//
//  MainCoordinator.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 22.05.2022.
//

import UIKit

final class MainCoordinator: Coordinator {

	private(set) var childCoordinators: [Coordinator] = []

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
	}

	func childDidFinish(_ childCoordinator: Coordinator) {
		if let index = childCoordinators.firstIndex(where: { (coordinator) -> Bool in
			return childCoordinator === coordinator
		}) {
			childCoordinators.remove(at: index)
		}
	}
}
