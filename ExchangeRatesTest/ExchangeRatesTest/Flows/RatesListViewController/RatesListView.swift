//
//  RatesListView.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 21.05.2022.
//

import UIKit

final class RatesListView: UIView {

	// MARK: Variables

	let identifier = RatesListTableViewCell().identifier
	private let mainStackViewHeightAnchor: CGFloat = 50.0
	private let labelFontSize: CGFloat = 16.0
	private let mainStackViewWidthAnchor: CGFloat = 0.45
	private let mainStackViewUIEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)

	// MARK: - Subviews

	private(set) lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .plain)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.register(RatesListTableViewCell.self, forCellReuseIdentifier: identifier)
		return tableView
	}()

	private(set) lazy var mainStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .horizontal
		stackView.distribution = .equalSpacing
		stackView.backgroundColor = .mainRedColor
		stackView.layoutMargins = mainStackViewUIEdgeInsets
		stackView.isLayoutMarginsRelativeArrangement = true
		return stackView
	}()

	private(set) lazy var currencyLable: UILabel = {
		let lable = UILabel()
		lable.translatesAutoresizingMaskIntoConstraints = false
		lable.text = "Валюта"
		lable.font = UIFont.systemFont(ofSize: labelFontSize, weight: .bold)
		lable.textColor = .white
		lable.textAlignment = .center
		return lable
	}()

	private(set) lazy var bayLable: UILabel = {
		let lable = UILabel()
		lable.translatesAutoresizingMaskIntoConstraints = false
		lable.font = UIFont.systemFont(ofSize: labelFontSize, weight: .bold)
		lable.textColor = .white
		lable.text = "Купить"
		lable.textAlignment = .center
		return lable
	}()

	private(set) lazy var sellLable: UILabel = {
		let lable = UILabel()
		lable.translatesAutoresizingMaskIntoConstraints = false
		lable.font = UIFont.systemFont(ofSize: labelFontSize, weight: .bold)
		lable.textColor = .white
		lable.text = "Продать"
		lable.textAlignment = .center
		return lable
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
		self.backgroundColor = .white
		self.mainStackView.addArrangedSubview(currencyLable)
		self.mainStackView.addArrangedSubview(bayLable)
		self.mainStackView.addArrangedSubview(sellLable)
		self.addSubview(mainStackView)
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

			self.currencyLable.widthAnchor.constraint(equalTo: self.mainStackView.widthAnchor,
													  multiplier: mainStackViewWidthAnchor),

			self.mainStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
			self.mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
			self.mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
			self.mainStackView.heightAnchor.constraint(equalToConstant: mainStackViewHeightAnchor),

			self.tableView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor),
			self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
			self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
			self.tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
		])
	}
}
