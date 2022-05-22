//
//  AppCoordinator.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 21.05.2022.
//

import UIKit

protocol Coordinator: AnyObject {
	var childCoordinators: [Coordinator] { get }
	func start()
	func childDidFinish(_ childCoordinator: Coordinator)
}

final class AppCoordinator: Coordinator {

	var childCoordinators: [Coordinator] = []

	private let window: UIWindow

	init(window: UIWindow) {
		self.window = window
	}

	func start() {
		let naviganionController = UINavigationController()
		let mainCoordinator = MainCoordinator(navigationController: naviganionController)
		naviganionController.isNavigationBarHidden = false
		childCoordinators.append(mainCoordinator)
		mainCoordinator.start()

		window.rootViewController = naviganionController
		window.makeKeyAndVisible()
	}

	func childDidFinish(_ childCoordinator: Coordinator) {}
}
