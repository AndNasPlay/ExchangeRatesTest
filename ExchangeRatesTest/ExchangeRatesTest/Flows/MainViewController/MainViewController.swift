//
//  MainViewController.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 21.05.2022.
//

import UIKit

final class MainViewController: UIViewController, MainViewControllerViewDelegate {

	var viewModel: MainViewModel?

	// swiftlint:disable force_cast
	private var mainViewControllerView: MainViewControllerView {
		return self.view as! MainViewControllerView
	}
	// swiftlint:enable force_cast

	override func viewDidLoad() {
		super.viewDidLoad()
		updateMainView()
	}

	private func updateMainView() {
		self.view = MainViewControllerView()
		self.mainViewControllerView.delegate = self
	}

	// MARK: Delegate methods

	func getRates() {
		viewModel?.getRates()
	}
}
