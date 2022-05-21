//
//  CurrencySymbols.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 21.05.2022.
//

import UIKit

enum CurrencySymbols {
	case JPY
	case KZT
	case CHF
	case CNY
	case USD
	case BYN
	case EUR
	case NOK
	case TRY

	var image: UIImage {
		switch self {
		case .EUR:
			return UIImage(systemName: "eurosign.circle")!
		case .USD:
			return UIImage(systemName: "dollarsign.circle")!
		case .JPY:
			return UIImage(systemName: "yensign.circle")!
		case .KZT:
			return UIImage(systemName: "tengesign.circle")!
		case .CHF:
			return UIImage(systemName: "francsign.circle")!
		case .CNY:
			return UIImage(systemName: "yensign.circle")!
		case .BYN:
			return UIImage(systemName: "rublesign.circle")!
		case .NOK:
			return UIImage(systemName: "kipsign.circle")!
		case .TRY:
			return UIImage(systemName: "turkishlirasign.circle")!
		}
	}
}
