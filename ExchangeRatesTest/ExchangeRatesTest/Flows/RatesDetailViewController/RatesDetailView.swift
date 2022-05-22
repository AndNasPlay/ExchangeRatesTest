//
//  RatesDetailView.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 22.05.2022.
//

import UIKit

class RatesDetailView: UIView {

	// MARK: Variables

	let identifier = RatesDetailTableViewCell().identifier

	// MARK: - Subviews

	private(set) lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .grouped )
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.register(RatesDetailTableViewCell.self, forCellReuseIdentifier: identifier)
		return tableView
	}()

	// MARK: - Init

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.configureUI()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.configureUI()
	}

	private func configureUI() {
		self.addTableView()
		self.setupConstraints()
	}

	private func addTableView() {
		self.tableView.rowHeight = UITableView.automaticDimension
		self.addSubview(tableView)
	}

	// MARK: - Constraints init

	private func setupConstraints() {
		let safeArea = self.safeAreaLayoutGuide

		NSLayoutConstraint.activate([
			self.tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
			self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
			self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
			self.tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
		])
	}

	// MARK: Delegate methods

	@objc func handleFromDateSelectedValueChanged() {}
}
