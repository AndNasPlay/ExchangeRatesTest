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

	// MARK: Variables

	var viewModel: RatesListViewModel?

	private var disposeBag = DisposeBag()

	// swiftlint:disable force_cast
	private var ratesListView: RatesListView {
		return self.view as! RatesListView
	}
	// swiftlint:enable force_cast

	override func viewDidLoad() {
		super.viewDidLoad()
		self.viewModel?.fetchRates()
		updateMainView()
		bindTableView()
		navigationItem.title = viewModel?.title
	}

	private func updateMainView() {
		self.view = RatesListView()
	}

	func bindTableView() {
		ratesListView.tableView.rx.setDelegate(self).disposed(by: disposeBag)
		viewModel?.rates.bind(to: ratesListView.tableView.rx.items(cellIdentifier: ratesListView.identifier,
																   cellType: RatesListTableViewCell.self)) { (_, item, cell) in
			let fromImage = self.viewModel?.getCurrencySymbol(value: item.fromCountry)
			let toImage = self.viewModel?.getCurrencySymbol(value: item.toCountry)
			cell.configureCell(item: item,
							   fromImage: (fromImage ?? UIImage(systemName: "dollarsign.circle"))!,
							   toImage: (toImage ?? UIImage(systemName: "dollarsign.circle"))!)
		}.disposed(by: disposeBag)
	}
}

extension RatesListViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.viewModel?.didSelectRow(at: indexPath)
	}
}
