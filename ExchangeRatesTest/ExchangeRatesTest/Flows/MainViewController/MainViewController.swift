//
//  MainViewController.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 21.05.2022.
//

import UIKit

class MainViewController: UIViewController {

	private(set) lazy var mainButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.backgroundColor = .redButtonColor
		button.setTitle("Execute Payment", for: .normal)
		button.layer.cornerRadius = 50.0
		return button
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = .black
		self.navigationController?.navigationBar.isHidden = true
		setupUI()
		setupConstraints()
    }

	private func setupUI() {
		self.view.addSubview(mainButton)
		self.mainButton.addTarget(self, action: #selector(handleGetRates), for: .touchUpInside)
	}

	private func setupConstraints() {
		NSLayoutConstraint.activate([

			self.mainButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
			self.mainButton.heightAnchor.constraint(equalToConstant: 100.0),
			self.mainButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10.0),
			self.mainButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10.0),

		])
	}

	// MARK: Delegate methods

	@objc func handleGetRates() {
		let viewController = RatesListViewController()
		self.navigationController?.pushViewController(viewController, animated: true)
	}

}
