//
//  AppCoordinator.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 21.05.2022.
//

import UIKit

final class AppCoordinator: Coordinator {

	var childCoordinators: [Coordinator] = []

	private let window: UIWindow

	init(window: UIWindow) {
		self.window = window
	}

	func start() {
		let naviganionController = UINavigationController()
		naviganionController.navigationBar.tintColor = .mainRedColor
		let mainCoordinator = MainScreenCoordinator(navigationController: naviganionController)
		naviganionController.isNavigationBarHidden = false
		childCoordinators.append(mainCoordinator)
		mainCoordinator.start()

		window.rootViewController = naviganionController
		window.makeKeyAndVisible()
	}

	func childDidFinish(_ childCoordinator: Coordinator) {}
}
