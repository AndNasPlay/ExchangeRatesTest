//
//  MainViewControllerView.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 22.05.2022.
//

import UIKit

protocol MainViewControllerViewDelegate: AnyObject {
	func getRates()
}

final class MainViewControllerView: UIView {

	// MARK: Variables

	private let mainButtonHeightAnchor: CGFloat = 60.0
	private let mainButtonTopAnchor: CGFloat = 10.0
	private let mainButtonTrailingLeadingAnchor: CGFloat = 60.0
	private let logoImageViewHeightAnchor: CGFloat = 100.0
	private let logoImageViewTopAnchor: CGFloat = 150.0
	private let logoImageViewTrailingLeadingAnchor: CGFloat = 60.0

	weak var delegate: MainViewControllerViewDelegate?

	// MARK: - Subviews

	private(set) lazy var logoImageView: UIImageView = {
		let imageView = UIImageView(frame: .zero)
		imageView.image = UIImage(named: "logo")
		imageView.contentMode = .scaleToFill
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	private(set) lazy var mainButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.backgroundColor = UIColor.white.withAlphaComponent(0.5)
		button.setTitle("Курсы валют", for: .normal)
		button.setTitleColor(.black, for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
		button.layer.cornerRadius = mainButtonHeightAnchor / 4
		button.titleLabel?.adjustsFontSizeToFitWidth = true
		button.accessibilityIdentifier = "mainButton"
		return button
	}()

	private(set) lazy var bgImageView: UIImageView = {
		let imageView = UIImageView(frame: .zero)
		imageView.image = UIImage(named: "bgIMG")
		imageView.contentMode = .scaleToFill
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	// MARK: - Init

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setupUI()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.setupUI()
	}

	private func setupUI() {
		self.addSubview(bgImageView)
		self.addSubview(logoImageView)
		self.addSubview(mainButton)
		setupConstraints()
		self.mainButton.addTarget(self,
								  action: #selector(handleGetRates),
								  for: .touchUpInside)
	}

	// MARK: - Constraints init

	private func setupConstraints() {
		let safeArea = self.safeAreaLayoutGuide

		NSLayoutConstraint.activate([

			self.bgImageView.topAnchor.constraint(equalTo: self.topAnchor),
			self.bgImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			self.bgImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			self.bgImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),

			self.logoImageView.topAnchor.constraint(equalTo: self.topAnchor,
													constant: logoImageViewTopAnchor),
			self.logoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,
														constant: logoImageViewTrailingLeadingAnchor),
			self.logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor,
														 constant: -logoImageViewTrailingLeadingAnchor),
			self.logoImageView.heightAnchor.constraint(equalToConstant: logoImageViewHeightAnchor),

			self.mainButton.topAnchor.constraint(equalTo: safeArea.centerYAnchor,
												 constant: mainButtonTopAnchor),
			self.mainButton.heightAnchor.constraint(equalToConstant: mainButtonHeightAnchor),
			self.mainButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
													 constant: mainButtonTrailingLeadingAnchor),
			self.mainButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
													 constant: mainButtonTrailingLeadingAnchor),
			self.mainButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
													  constant: -mainButtonTrailingLeadingAnchor)
		])
	}

	// MARK: Delegate methods

	@objc func handleGetRates() {
		delegate?.getRates()
	}
}
