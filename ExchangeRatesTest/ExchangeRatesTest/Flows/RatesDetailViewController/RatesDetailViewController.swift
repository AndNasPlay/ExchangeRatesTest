//
//  RatesDetailViewController.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 22.05.2022.
//

import UIKit
import FlagKit
import RxSwift
import RxCocoa

final class RatesDetailViewController: UIViewController {

	// MARK: Variables

	var viewModel: RatesDetailViewModel?

	private var disposeBag = DisposeBag()

	// swiftlint:disable force_cast
	private var ratesDetailView: RatesDetailView {
		return self.view as! RatesDetailView
	}
	// swiftlint:enable force_cast

	override func viewDidLoad() {
		super.viewDidLoad()
		updateMainView()
		viewModel?.getSequence()
		bindTableView()
	}

	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		viewModel?.viewDidDisappear()
	}

	private func updateMainView() {
		self.view = RatesDetailView()
		self.viewModel?.configureView(view: self.ratesDetailView)
	}

	func bindTableView() {
		ratesDetailView.tableView.rx.setDelegate(self).disposed(by: disposeBag)
		viewModel?.ratesSequence.bind(to: ratesDetailView.tableView.rx.items(cellIdentifier: ratesDetailView.identifier,
																   cellType: RatesDetailTableViewCell.self)) { (indexPath, item, cell) in
			cell.configureCell(ratesValue: item, counter: indexPath)
		}.disposed(by: disposeBag)
	}
}

extension RatesDetailViewController: UITableViewDelegate { }
