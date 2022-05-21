//
//  ViewController.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 21.05.2022.
//

import UIKit
import RxSwift
import RxCocoa

class RatesListViewController: UIViewController {

	private var viewModel = RatesListViewModel()

	private var disposeBag = DisposeBag()

	private let identifier = RatesTableViewCell().identifier

	private(set) lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .plain)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.register(RatesTableViewCell.self, forCellReuseIdentifier: identifier)
		return tableView
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		addSubviews()
		setupUI()
		self.navigationController?.navigationBar.isHidden = false
		self.viewModel.fetchRates()
		bindTableView()
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		self.navigationController?.navigationBar.isHidden = true
	}

	func bindTableView() {
		tableView.rx.setDelegate(self).disposed(by: disposeBag)
		viewModel.rates.bind(to: tableView.rx.items(cellIdentifier: identifier,
													cellType: RatesTableViewCell.self)) { (_, item, cell) in
			let symbolImage = self.viewModel.getCurrencySymbol(value: item.currMnemTo!)
			cell.configureCell(item: item, image: symbolImage)
		}.disposed(by: disposeBag)
	}

	func addSubviews() {
		self.view.addSubview(tableView)
	}

	func setupUI() {
		NSLayoutConstraint.activate([
			self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
			self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
			self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
			self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
		])
	}
}

extension RatesListViewController: UITableViewDelegate { }
