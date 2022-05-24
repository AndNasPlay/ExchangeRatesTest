//
//  RatesListTableViewCell.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 21.05.2022.
//

import UIKit

final class RatesListTableViewCell: UITableViewCell {

	// MARK: Variables

	let identifier: String = "ratesTableViewCell"

	private let nameStackViewWidthAnchor: CGFloat = 0.45
	private let cellStackViewPadding: CGFloat = 10
	private let cellStackViewRightPadding: CGFloat = 25
	private let labelFontSize: CGFloat = 16.0
	private let stackViewsSpacing: CGFloat = 10.0

	// MARK: - Subviews

	private(set) lazy var imgFromImageView: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		return image
	}()

	private(set) lazy var imgToImageView: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		return image
	}()

	private(set) lazy var fromNameLable: UILabel = {
		let lable = UILabel()
		lable.font = UIFont.systemFont(ofSize: labelFontSize, weight: .bold)
		lable.numberOfLines = 0
		return lable
	}()

	private(set) lazy var toNameLable: UILabel = {
		let lable = UILabel()
		lable.font = UIFont.systemFont(ofSize: labelFontSize, weight: .bold)
		lable.numberOfLines = 0
		return lable
	}()

	private(set) lazy var buypriceLable: UILabel = {
		let lable = UILabel()
		lable.sizeToFit()
		lable.textAlignment = .left
		return lable
	}()

	private(set) lazy var sellpriceLable: UILabel = {
		let lable = UILabel()
		lable.sizeToFit()
		lable.textAlignment = .left
		return lable
	}()

	private(set) lazy var cellStackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.distribution = .fill
		stack.spacing = stackViewsSpacing
		return stack
	}()

	private(set) lazy var imageStackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.distribution = .fillProportionally
		stack.spacing = stackViewsSpacing
		return stack
	}()

	private(set) lazy var nameStackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.distribution = .fillProportionally
		stack.spacing = stackViewsSpacing
		return stack
	}()

	// MARK: - Init

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .default, reuseIdentifier: identifier)
		setupUI()
		setupConstraints()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	func configureCell(item: Rates, fromImage: UIImage, toImage: UIImage) {

		self.fromNameLable.text = item.currMnemFrom
		self.toNameLable.text = item.currMnemTo
		self.imgFromImageView.image = fromImage
		self.imgToImageView.image = toImage

		let buy = String(item.buy.prefix(5))
		let sale = String(item.sale.prefix(5))

		self.buypriceLable.text = buy
		self.sellpriceLable.text = sale
	}

	private func setupUI() {

		self.imageStackView.addArrangedSubview(imgFromImageView)
		self.imageStackView.addArrangedSubview(imgToImageView)

		self.nameStackView.addArrangedSubview(fromNameLable)
		self.nameStackView.addArrangedSubview(toNameLable)

		self.cellStackView.addArrangedSubview(imageStackView)
		self.cellStackView.addArrangedSubview(nameStackView)
		self.cellStackView.addArrangedSubview(buypriceLable)
		self.cellStackView.addArrangedSubview(sellpriceLable)

		self.contentView.addSubview(cellStackView)
	}

	// MARK: - Constraints init

	private func setupConstraints() {

		NSLayoutConstraint.activate([

			self.nameStackView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor,
													  multiplier: nameStackViewWidthAnchor),

			self.cellStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor,
													constant: cellStackViewPadding),
			self.cellStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,
														constant: cellStackViewPadding),
			self.cellStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,
														 constant: -cellStackViewRightPadding),
			self.cellStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,
													   constant: -cellStackViewPadding)
		])
	}
}
