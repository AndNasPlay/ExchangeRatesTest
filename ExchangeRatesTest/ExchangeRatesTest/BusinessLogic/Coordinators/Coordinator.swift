//
//  Coordinator.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 23.05.2022.
//

import Foundation

protocol Coordinator: AnyObject {
	var childCoordinators: [Coordinator] { get }
	func start()
	func childDidFinish(_ childCoordinator: Coordinator)
}
