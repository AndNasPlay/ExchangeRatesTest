//
//  RatesDetailViewController.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 22.05.2022.
//

import UIKit
import RxSwift
import RxCocoa

class RatesDetailViewController: UIViewController {

	// MARK: Variables

	var viewModel: RatesDetailViewModel?

	private var disposeBag = DisposeBag()

	// swiftlint:disable force_cast
	private var ratesListView: RatesListView {
		return self.view as! RatesListView
	}
	// swiftlint:enable force_cast

	override func viewDidLoad() {
		super.viewDidLoad()
//		self.viewModel
		updateMainView()
//		bindTableView()
	}

	private func updateMainView() {
		self.view = RatesListView()
	}

//	func bindTableView() {
//		ratesListView.tableView.rx.setDelegate(self).disposed(by: disposeBag)
//		viewModel.rates.bind(to: ratesListView.tableView.rx.items(cellIdentifier: ratesListView.identifier,
//																  cellType: RatesListTableViewCell.self)) { (_, item, cell) in
//			let symbolImage = self.viewModel.getCurrencySymbol(value: item.currMnemTo!)
//			cell.configureCell(item: item, image: symbolImage)
//		}.disposed(by: disposeBag)
//	}
}

extension RatesDetailViewController: UITableViewDelegate { }
