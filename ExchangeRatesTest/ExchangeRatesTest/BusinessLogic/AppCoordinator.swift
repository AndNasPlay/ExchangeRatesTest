//
//  AppCoordinator.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 21.05.2022.
//

import UIKit

class AppCoordinator {

	private let window: UIWindow

	init(window: UIWindow) {
		self.window = window
	}

	func start() {
		let viewController = MainViewController()
		let naviganionController = UINavigationController(rootViewController: viewController)
		window.rootViewController = naviganionController
		window.makeKeyAndVisible()
	}
}
