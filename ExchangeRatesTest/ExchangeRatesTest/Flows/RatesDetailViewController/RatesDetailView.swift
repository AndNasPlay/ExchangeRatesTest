//
//  RatesDetailView.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 22.05.2022.
//

import UIKit

final class RatesDetailView: UIView {

	// MARK: Variables

	let identifier = RatesDetailTableViewCell().identifier

	private let mainStackViewHeightAnchor: CGFloat = 50.0
	private let mainStackViewPadding: CGFloat = 20.0
	private let tableViewTopAnchor: CGFloat = 20.0
	private let labelFontSize: CGFloat = 20.0

	// MARK: - Subviews

	private(set) lazy var mainStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .horizontal
		stackView.distribution = .fillProportionally
		return stackView
	}()

	private(set) lazy var fromImageView: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleAspectFill
		return image
	}()

	private(set) lazy var toImageView: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleAspectFill
		return image
	}()

	private(set) lazy var arrowImageView: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.image = UIImage(systemName: "arrow.left.arrow.right")
		image.tintColor = .mainRedColor
		return image
	}()

	private(set) lazy var fromLable: UILabel = {
		let lable = UILabel()
		lable.translatesAutoresizingMaskIntoConstraints = false
		lable.textAlignment = .center
		lable.sizeToFit()
		lable.font = UIFont.systemFont(ofSize: labelFontSize, weight: .bold)
		return lable
	}()

	private(set) lazy var toLable: UILabel = {
		let lable = UILabel()
		lable.translatesAutoresizingMaskIntoConstraints = false
		lable.textAlignment = .center
		lable.sizeToFit()
		lable.font = UIFont.systemFont(ofSize: labelFontSize, weight: .bold)
		return lable
	}()

	private(set) lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .grouped )
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.register(RatesDetailTableViewCell.self, forCellReuseIdentifier: identifier)
		tableView.backgroundColor = .white
		tableView.separatorStyle = .none
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
		self.backgroundColor = .white
		self.createStackView()
		self.addTableView()
		self.setupConstraints()
	}

	private func createStackView() {
		mainStackView.addArrangedSubview(fromImageView)
		mainStackView.addArrangedSubview(fromLable)
		mainStackView.addArrangedSubview(arrowImageView)
		mainStackView.addArrangedSubview(toLable)
		mainStackView.addArrangedSubview(toImageView)
		self.addSubview(mainStackView)
	}

	private func addTableView() {
		self.tableView.rowHeight = UITableView.automaticDimension
		self.addSubview(tableView)
	}

	// MARK: - Constraints init

	private func setupConstraints() {
		let safeArea = self.safeAreaLayoutGuide

		NSLayoutConstraint.activate([

			self.mainStackView.topAnchor.constraint(equalTo: safeArea.topAnchor,
													constant: mainStackViewPadding),
			self.mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
														constant: mainStackViewPadding),
			self.mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
														 constant: -mainStackViewPadding),
			self.mainStackView.heightAnchor.constraint(equalToConstant: mainStackViewHeightAnchor),

			self.tableView.topAnchor.constraint(equalTo: self.mainStackView.bottomAnchor,
												constant: tableViewTopAnchor),
			self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
			self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
			self.tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
		])
	}
}
