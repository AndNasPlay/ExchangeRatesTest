//
//  RatesTableViewCell.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 21.05.2022.
//

import UIKit

class RatesTableViewCell: UITableViewCell {

	let identifier: String = "ratesTableViewCell"

	private let symbolImageViewWidthAnchorAndHeightAnchor: CGFloat = 0.1
	private let nameStackViewWidthAnchor: CGFloat = 0.5
	private let cellStackViewPadding: CGFloat = 10

	private(set) lazy var symbolImageView: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.tintColor = .black
		return image
	}()

	private(set) lazy var nameLable: UILabel = {
		let lable = UILabel()
		lable.numberOfLines = 0
		return lable
	}()

	private(set) lazy var abbreviationNameLable: UILabel = {
		let lable = UILabel()
		lable.numberOfLines = 0
		return lable
	}()

	private(set) lazy var priceLable: UILabel = {
		let lable = UILabel()
		lable.sizeToFit()
		return lable
	}()

	private(set) lazy var cellStackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()

	private(set) lazy var nameStackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		return stack
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .default, reuseIdentifier: identifier)
		setupUI()
		setupConstraints()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	func configureCell(item: Rates, image: UIImage) {
		self.nameLable.text = item.name
		self.abbreviationNameLable.text = item.currMnemTo
		self.symbolImageView.image = image
		self.priceLable.text = "1 \(item.currMnemTo ?? "") = \(item.buy ?? "") RUB"
	}

	private func setupUI() {

		self.nameStackView.addArrangedSubview(abbreviationNameLable)
		self.nameStackView.addArrangedSubview(nameLable)

		self.contentView.addSubview(symbolImageView)
		self.cellStackView.addArrangedSubview(nameStackView)
		self.cellStackView.addArrangedSubview(priceLable)

		self.contentView.addSubview(cellStackView)
	}

	private func setupConstraints() {
		NSLayoutConstraint.activate([

			self.symbolImageView.widthAnchor.constraint(equalTo: self.cellStackView.widthAnchor,
														multiplier: symbolImageViewWidthAnchorAndHeightAnchor),
			self.symbolImageView.heightAnchor.constraint(equalTo: self.cellStackView.widthAnchor,
														 multiplier: symbolImageViewWidthAnchorAndHeightAnchor),

			self.symbolImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
			self.symbolImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,
														  constant: cellStackViewPadding),

			self.nameStackView.widthAnchor.constraint(equalTo: self.cellStackView.widthAnchor,
													  multiplier: nameStackViewWidthAnchor),

			self.cellStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor,
													constant: cellStackViewPadding),
			self.cellStackView.leadingAnchor.constraint(equalTo: self.symbolImageView.trailingAnchor,
														constant: cellStackViewPadding),
			self.cellStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,
														 constant: -cellStackViewPadding),
			self.cellStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,
													   constant: -cellStackViewPadding)
		])
	}
}
