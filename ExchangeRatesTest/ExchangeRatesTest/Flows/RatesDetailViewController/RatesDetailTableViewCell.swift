//
//  RatesDetailTableViewCell.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 22.05.2022.
//

import UIKit

final class RatesDetailTableViewCell: UITableViewCell {

	// MARK: Variables

	let identifier: String = "ratesDetailTableViewCell"

	private let titleLableWidthAnchor: CGFloat = 0.3
	private let labelFontSize: CGFloat = 18.0
	private(set) lazy var stackViewPadding: CGFloat = 20.0
	private(set) lazy var stackViewSpacing: CGFloat = 20.0
	private(set) lazy var stackViewCornerRadius: CGFloat = 15.0
	private(set) lazy var stackViewBorderWidth: CGFloat = 1.0
	private(set) lazy var stackViewEdgeInsets: NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(top: 20,
																								 leading: 20,
																								 bottom: 20,
																								 trailing: 20)

	// MARK: - Subviews

	private(set) lazy var symbolImageView: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.tintColor = .mainRedColor
		image.image = UIImage(systemName: "circle.circle.fill")
		image.contentMode = .scaleAspectFit
		return image
	}()

	private(set) lazy var titleLable: UILabel = {
		let lable = UILabel()
		lable.textAlignment = .left
		lable.font = UIFont.systemFont(ofSize: labelFontSize, weight: .semibold)
		return lable
	}()

	private(set) lazy var subtitleLable: UILabel = {
		let lable = UILabel()
		lable.textAlignment = .left
		lable.font = UIFont.systemFont(ofSize: labelFontSize, weight: .semibold)
		lable.numberOfLines = 0
		return lable
	}()

	private(set) lazy var lablesStackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.layer.borderColor = UIColor.lightGray.cgColor
		stack.spacing = stackViewSpacing
		stack.distribution = .fill
		stack.isLayoutMarginsRelativeArrangement = true
		stack.directionalLayoutMargins = stackViewEdgeInsets
		stack.layer.borderWidth = stackViewBorderWidth
		stack.layer.borderColor = UIColor.lightGray.cgColor
		stack.layer.cornerRadius = stackViewCornerRadius
		return stack
	}()

	// MARK: - Init

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .default, reuseIdentifier: identifier)
		selectionStyle = .none
		setupUI()
		setupConstraints()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	func configureCell(ratesValue: String, counter: Int) {
		switch counter {
		case 0:
			self.titleLable.text = "Name:"
			self.subtitleLable.text = ratesValue
		case 1:
			self.titleLable.text = "Buy:"
			self.subtitleLable.text = ratesValue
		case 2:
			self.titleLable.text = "DeltaBuy:"
			self.subtitleLable.text = ratesValue
		case 3:
			self.titleLable.text = "Sale:"
			self.subtitleLable.text = ratesValue
		case 4:
			self.titleLable.text = "DeltaSale:"
			self.subtitleLable.text = ratesValue
		case 5:
			self.titleLable.text = "Basic:"
			self.subtitleLable.text = ratesValue
		case 6:
			self.titleLable.text = "Tp:"
			self.subtitleLable.text = ratesValue
		default:
			break
		}
	}

	private func setupUI() {
		self.lablesStackView.addArrangedSubview(symbolImageView)
		self.lablesStackView.addArrangedSubview(titleLable)
		self.lablesStackView.addArrangedSubview(subtitleLable)
		self.contentView.addSubview(lablesStackView)
	}

	// MARK: - Constraints init

	private func setupConstraints() {
		NSLayoutConstraint.activate([

			self.titleLable.widthAnchor.constraint(equalTo: self.lablesStackView.widthAnchor,
												   multiplier: titleLableWidthAnchor),

			self.lablesStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor,
													  constant: stackViewPadding),
			self.lablesStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,
														  constant: stackViewPadding),
			self.lablesStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,
														   constant: -stackViewPadding),
			self.lablesStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,
														 constant: -stackViewPadding)
		])
	}
}
